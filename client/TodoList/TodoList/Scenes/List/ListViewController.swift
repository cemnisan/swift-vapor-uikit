//
//  ListViewController.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: ListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var lists: [ListPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.load()
    }
}

extension ListViewController: ListViewModelDelegate {
    
    func handleViewModelOutput(_ output: ListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            print(isLoading)
        case .showList(let response):
            self.lists = response
            tableView.reloadData()
        }
    }
    
    func navigate(to route: ListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = ListDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let list = lists[indexPath.row]

        cell.textLabel?.text = list.title
        cell.detailTextLabel?.text = "cem"
        
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectList(at: indexPath.row)
    }
}
