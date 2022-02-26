//
//  AddListContracts.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import Foundation

protocol AddListViewModelProtocol {
    var delegate: AddListViewModelDelegate? { get set }
    func add(with title: String,
             content: String,
             expectedDate: String,
             selectedDate: String) 
}

enum AddListViewModelOutput {
    case setLoading(Bool)
    case showSuccessAdded(Bool)
    case showError(Error)
}

protocol AddListViewModelDelegate {
    func handleOutput(_ output: AddListViewModelOutput)
}
