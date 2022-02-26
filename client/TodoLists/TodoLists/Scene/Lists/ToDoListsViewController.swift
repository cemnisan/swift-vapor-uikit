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
    
    private func configureCheckMark(with isDone: Bool)
    {
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
        case .successUpdate(let isCompleted):
            configureCheckMark(with: isCompleted)
        case .successDelete(let isDeleted):
            configureCheckMark(with: isDeleted)
        case .showError(let error):
            AlertManager.shared.alertForError(on: self,
                                              title: "Error",
                                              message: error.localizedDescription)
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
        cell.configureCell(with: todoList, segmentTitle: getSegmentTitle())
        
        return cell
    }
}

// MARK: - Table View's Delegate
extension ToDoListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let selectedList = self.todoLists[indexPath.row]
        let selectedSegment = self.getSegmentTitle()
        
        let delete = UIContextualAction(style: .destructive,
                                        title: "🗑") { [weak self] _,_,_ in
            guard let self = self else { return }
            
            AlertManager.shared.alertForDeleteList(on: self) {
                self.todoListViewModel.delete(with: selectedList.id, selectedSegment)
            }
        }
        
        if selectedSegment == .notCompleted {
            let complete = UIContextualAction(style: .normal,
                                              title: "💯") { [weak self] _, _, _ in
                guard let self = self else { return }
                
                self.todoListViewModel.updateList(with: selectedList.id,
                                                  title: selectedList.title,
                                                  content: selectedList.content,
                                                  isCompleted: true)
            }
            return UISwipeActionsConfiguration(actions: [delete, complete])
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
