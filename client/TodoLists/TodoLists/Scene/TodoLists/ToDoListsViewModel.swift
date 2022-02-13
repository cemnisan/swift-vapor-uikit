//
//  ToDoListsViewModel.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

final class ToDoListViewModel: ToDoListViewModelProtocol {
    
    weak var delegate: ToDoListViewModelDelegate?
    private let service: IToDoListService
    private var todoLists: [List] = []
    
    init(service: IToDoListService) {
        self.service = service
    }
    
    func load() {
        notify(.setLoading(true))
        
        service.getAllLists { [weak self] results in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch results {
            case .success(let lists):
                self.todoLists = lists.results
                let presentation = self.todoLists.map { ToDoListPresentation(title: $0.title, content: $0.content) }
                self.notify(.showToDoLists(presentation))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleToDoListViewModelOutput(output)
    }
}
