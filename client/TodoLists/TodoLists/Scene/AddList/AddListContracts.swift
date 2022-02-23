//
//  AddListContracts.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import Foundation

protocol AddListViewModelProtocol {
    var delegate: AddListViewModelDelegate? { get set }
    func add(with title: String, _ content: String)
}

enum AddListViewModelOutput {
    case setLoading(Bool)
    case showSuccessAdded(Bool)
    case isEmptyError
}

protocol AddListViewModelDelegate {
    func handleOutput(_ output: AddListViewModelOutput)
}
