//
//  ToDoListsViewController.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit
import ToDoListsAPI

final class ToDoListsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completionSegment: UISegmentedControl!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var checkMark: UIButton!
    
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
        
        todoListViewModel.load(with: getSegmentTitle())
    }
}

// MARK: - Buttons Pressed.
extension ToDoListsViewController {
    @IBAction func segmentPressed(_ sender: UISegmentedControl)
    {
        selectedSegment = sender.titleForSegment(at: sender.selectedSegmentIndex)
        todoListViewModel.load(with: getSegmentTitle())
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem)
    {
        todoListViewModel.load(with: getSegmentTitle())
    }
    
    @IBAction func addListPressed(_ sender: UIBarButtonItem)
    {
        todoListViewModel.selectAddButton()
    }
}

// MARK: - Get Segment Title
extension ToDoListsViewController {
    private func getSegmentTitle() -> SelectSegmentTitle {
        guard let segmentTitle = selectedSegment else { return .notCompleted }
        let title = SelectSegmentTitle.getTitle(with: segmentTitle)
        
        return title
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
        activityIndicatorView.isHidden = false
        activityIndicatorView.layer.cornerRadius = 6
    }
    
    private func configureLoadingIndicator(with isLoading: Bool)
    {
        if (isLoading) {
            activityIndicatorView.isHidden = false
            loadingActivityIndicator.isHidden = false
            checkMark.isHidden = true
            loadingActivityIndicator.startAnimating()
        } else {
            activityIndicatorView.isHidden = true
            loadingActivityIndicator.stopAnimating()
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
            todoLists = []
            todoLists = lists
            tableView.reloadData()
        case .successUpdate(let isCompleted):
            configureCheckMark(with: isCompleted)
        case .successDelete(let isDeleted):
            configureCheckMark(with: isDeleted) // to do: show checkmark.
        case .showError(let error):
            print(error) // todo: show error message.
        }
    }
    
    func configureCheckMark(with isDone: Bool)
    {
        print("..")
        if (isDone) {
            activityIndicatorView.isHidden = false
            checkMark.isHidden = false
            loadingActivityIndicator.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.activityIndicatorView.isHidden = true }
        } else {
            checkMark.isHidden = true
            activityIndicatorView.isHidden = false
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

// MARK: - Table View's Delegate
extension ToDoListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] _,_,_ in
            guard let self = self else { return }
            
            let selectedList = self.todoLists[indexPath.row].id
            let selectedSegment = self.getSegmentTitle()
            self.alertToDeleteList(id: selectedList, segmenTitle: selectedSegment)
        }
        
        let complete = UIContextualAction(style: .normal,
                                          title: "Complete") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            let selectedList = self.todoLists[indexPath.row]
            self.todoListViewModel.updateList(with: selectedList.id,
                                              title: selectedList.title,
                                              content: selectedList.content,
                                              isCompleted: true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, complete])
    }
}

// MARK: - Create Alert For Deletion
extension ToDoListsViewController {
    private func alertToDeleteList(id: UUID,
                                    segmenTitle: SelectSegmentTitle)
    {
        let alert = UIAlertController(
            title: "Delete List",
            message: "Are u sure??",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            guard let self = self else { return }
            self.todoListViewModel.delete(with: id, segmenTitle)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
