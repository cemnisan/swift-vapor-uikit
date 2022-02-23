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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var completionSegment: UISegmentedControl!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var todoListViewModel: ToDoListViewModelProtocol! {
        didSet {
            todoListViewModel.delegate = self
        }
    }
    
    private var todoLists: [ToDoListPresentation] = []
    private var selectedSegment: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureUIElement()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchLists()
    }
}

// MARK: - Fetch List
extension ToDoListsViewController {
    private func fetchLists()
    {
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
    @IBAction func segmentPressed(_ sender: UISegmentedControl)
    {
        selectedSegment = sender.titleForSegment(at: sender.selectedSegmentIndex)
        fetchLists()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem)
    {
        fetchLists()
    }

    // todo: 1. code refactoring. 2. may you can write cleaner.
    @IBAction func addListPressed(_ sender: UIBarButtonItem)
    {

        todoListViewModel.selectAddButton()
    }
    
}

// MARK: - View Controller's Configurators
extension ToDoListsViewController {
    
   private func configureTableView()
   {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: Constant.TableView.listsNibName,
                             bundle: nil), forCellReuseIdentifier: Constant.TableView.listsCell)
    }
    
    private func configureUIElement()
    {
        loadingActivityIndicator.isHidden = false
        
    }
    
    private func configureLoadingIndicator(with isLoading: Bool)
    {
        if (isLoading) {
            loadingActivityIndicator.isHidden = false
        } else {
            loadingActivityIndicator.isHidden = true
        }
    }
}

// MARK: - View Model's Delegate
extension ToDoListsViewController: ToDoListViewModelDelegate {
    func navigate(to route: ToDoListViewRoute) {
        switch route {
        case .add(let viewModel):
            let viewController = AddListBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
    
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            configureLoadingIndicator(with: isLoading)
        case .showToDoLists(let lists):
            todoLists = lists
            tableView.reloadData()
        case .showError(let error):
            print(error) // todo: show error message.
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
