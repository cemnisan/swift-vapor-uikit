//
//  ToDoListsBuidler.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit

final class ToDoListsBuilder {
    static func make() -> ToDoListsViewController {
        let storyboard = UIStoryboard(name: "ToDoLists", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ToDoListsViewController") as! ToDoListsViewController
        viewController.todoListViewModel = ToDoListViewModel(service: AppContainer.shared.service)
        return viewController
    }
}
