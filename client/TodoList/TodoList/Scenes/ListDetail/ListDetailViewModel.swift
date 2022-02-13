//
//  ListDetailViewModel.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation
import TodoListAPI

final class ListDetailViewModel: ListDetailViewModelProtocol {
    var delegate: ListDetailViewModelDelegate?
    private let presentation: ListPresentation
    
    init(list: List) {
        self.presentation = ListPresentation(title: list.title, content: list.content)
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }

}
