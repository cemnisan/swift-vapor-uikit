//
//  ListContracts.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation

protocol ListViewModelProtocol {
    var delegate: ListViewModelDelegate? { get set }
    func load()
    func selectList(at index: Int)
}

enum ListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showList([ListPresentation])
}

enum ListViewRoute {
    case detail(ListDetailViewModelProtocol)
}

protocol ListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ListViewModelOutput)
    func navigate(to route: ListViewRoute)
}
