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
    
    var todoListViewModel: ToDoListViewModelProtocol! {
        didSet {
            todoListViewModel.delegate = self
        }
    }
    
    var todoLists: [ToDoListPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElement()
        configureTableView()
        todoListViewModel.load()
    }
}

// MARK: - Buttons Pressed.
extension ToDoListsViewController {
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {} // todo
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
    }
}

// MARK: - View Model's Delegate
extension ToDoListsViewController: ToDoListViewModelDelegate {
    
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            if !isLoading { loadingActivityIndicator.isHidden = true }
        case .showToDoLists(let lists):
            todoLists = lists
            tableView.reloadData()
        case .showError(let error):
            print(error)
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
