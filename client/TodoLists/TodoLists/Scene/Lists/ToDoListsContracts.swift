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
    func updateList(with id: UUID,
                    title: String,
                    content: String,
                    isCompleted: Bool)
    func selectAddButton()
}

enum ToDoListViewModelOutput {
    case setLoading(Bool)
    case showToDoLists([ToDoListPresentation])
    case successDelete(Bool)
    case successUpdate(Bool)
    case showError(Error)
}

enum ToDoListViewRoute {
    case add(AddListViewModelProtocol)
}

protocol ToDoListViewModelDelegate: AnyObject {
    func handleToDoListViewModelOutput(_ output: ToDoListViewModelOutput)
    func navigate(to route: ToDoListViewRoute)
}

