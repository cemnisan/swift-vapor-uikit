//
//  ToDoListsContracts.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

protocol ToDoListViewModelProtocol {
    var delegate: ToDoListViewModelDelegate? { get set }
    func load(with segmenTitle: SelectSegmentTitle)
    func delete(with id: UUID, _ segmentTitle: SelectSegmentTitle)
    func selectAddButton()
}

enum ToDoListViewModelOutput {
    case setLoading(Bool)
    case showToDoLists([ToDoListPresentation])
    case showError(Error)
    case successDelete(Bool)
}

enum ToDoListViewRoute {
    case add(AddListViewModelProtocol)
}

protocol ToDoListViewModelDelegate: AnyObject {
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput)
    func navigate(to route: ToDoListViewRoute)
}

