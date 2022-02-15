//
//  ToDoListsViewController.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit
import ToDoListsAPI

final class ToDoListsViewController: UIViewController {
    
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completionSegment: UISegmentedControl!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var todoListViewModel: ToDoListViewModelProtocol! {
        didSet {
            todoListViewModel.delegate = self
        }
    }
    
    var todoLists: [ToDoListPresentation] = []
    
    var selectedSegment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElement()
        configureTableView()
        fetchLists()
    }
}

// MARK: - Fetch List
extension ToDoListsViewController {
    private func fetchLists() {
        // 1. When the view is loaded, fetch first segment title's items (first segment: .notCompleted)
        // 2. If the user selects any segment title (for ex: .completed) fetch `.completed` list.
        if let segmentsTitle = selectedSegment {
            let getSegmentsTitle = SelectSegmentTitle.getTitle(with: segmentsTitle)!
            todoListViewModel.load(with: getSegmentsTitle)
        } else {
            todoListViewModel.load(with: .notCompleted)
        }
    }
}

// MARK: - Buttons Pressed.
extension ToDoListsViewController {
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        selectedSegment = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        fetchLists()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        fetchLists()
    }

    // todo: 1. code refactoring. 2. may you can write cleaner.
    @IBAction func addListPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New To Do", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (titleTextField) in
            titleTextField.placeholder = "Enter To Do's Title."
        }
        
        alertController.addTextField { (detailTextField) in
            detailTextField.placeholder = "Enter To Do's Detail."
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let titleTextField = alertController.textFields![0] as UITextField
            let detailTextField = alertController.textFields![1] as UITextField
            
            guard let title = titleTextField.text, let detail = detailTextField.text else { return }
            self.todoListViewModel.add(with: title, detail)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - View Controller's Configurators
extension ToDoListsViewController {
    
   private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: Constant.TableView.listsNibName,
                             bundle: nil), forCellReuseIdentifier: Constant.TableView.listsCell)
    }
    
    private func configureUIElement() {
        loadingActivityIndicator.isHidden = false
        checkMarkView.isHidden = true
        
        checkMarkView.layer.cornerRadius = 6
    }
    
    private func configureLoadingIndicator(with isLoading: Bool) {
        
        if (isLoading) {
            loadingActivityIndicator.isHidden = false
        } else {
            loadingActivityIndicator.isHidden = true
        }
    }
    
    private func configureMarkView(with isAdded: Bool) {
        print(isAdded)
        if (isAdded) {
            checkMarkView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.checkMarkView.isHidden = true
                
            }
        }
    }
}

// MARK: - View Model's Delegate
extension ToDoListsViewController: ToDoListViewModelDelegate {
    
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput) {
        
        switch output {
        case .setLoading(let isLoading):
            configureLoadingIndicator(with: isLoading)
        case .showToDoLists(let lists):
            todoLists = lists
            tableView.reloadData()
        case .showError(let error):
            print(error) // todo: show error message.
        case .showSuccessAdded(let isAdded, let newList):
            todoLists.append(newList)
            configureMarkView(with: isAdded)
            tableView.reloadData()
        }
    }
}

// MARK: - Table View's Data Source
extension ToDoListsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return todoLists.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TableView.listsCell,
                                                 for: indexPath) as! ToDoListsTableViewCell
        let todoList = todoLists[indexPath.row]
        cell.configureCell(with: todoList)
        
        return cell
    }
}

// MARK: - Table View's Data Delegate
extension ToDoListsViewController: UITableViewDelegate {}
