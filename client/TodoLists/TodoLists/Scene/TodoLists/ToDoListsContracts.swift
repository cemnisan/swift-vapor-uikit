//
//  ToDoListsContracts.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

protocol ToDoListViewModelProtocol {
    var delegate: ToDoListViewModelDelegate? { get set }
    func load(with segmenTitle: SelectSegmentTitle)
    func add(with title: String, _ content: String)
}

enum ToDoListViewModelOutput {
    case setLoading(Bool)
    case showSuccessAdded(Bool, ToDoListPresentation)
    case showToDoLists([ToDoListPresentation])
    case showError(Error)
}

protocol ToDoListViewModelDelegate: AnyObject {
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput)
}

