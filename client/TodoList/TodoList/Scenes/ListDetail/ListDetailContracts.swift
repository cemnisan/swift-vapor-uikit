//
//  ListDetailContracts.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation

protocol ListDetailViewModelDelegate: AnyObject {
    func showDetail(_ presentation: ListPresentation)
}

protocol ListDetailViewModelProtocol {
    var delegate: ListDetailViewModelDelegate? { get set }
    func load()
}
