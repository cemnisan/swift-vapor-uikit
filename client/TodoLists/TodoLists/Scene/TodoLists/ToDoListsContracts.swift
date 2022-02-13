//
//  ToDoListsContracts.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

protocol ToDoListViewModelProtocol {
    var delegate: ToDoListViewModelDelegate? { get set }
    func load()
}

enum ToDoListViewModelOutput {
    case setLoading(Bool)
    case showToDoLists([ToDoListPresentation])
    case showError(Error)
}

protocol ToDoListViewModelDelegate: AnyObject {
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput)
}

