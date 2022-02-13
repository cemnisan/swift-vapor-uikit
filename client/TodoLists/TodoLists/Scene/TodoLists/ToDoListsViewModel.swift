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
    private var presentation: [ToDoListPresentation] = []
    
    init(service: IToDoListService) {
        self.service = service
    }
}

extension ToDoListViewModel {
    
    func load() {
        notify(.setLoading(true))
        
        service.getAllLists { [weak self] results in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch results {
            case .success(let lists):
                self.todoLists = lists.results
                self.presentation = self.todoLists.map { ToDoListPresentation(title: $0.title, content: $0.content) }
                self.notify(.showToDoLists(self.presentation))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func add(with title: String, _ content: String) {
        notify(.setLoading(true))
        
        service.addLists(with: title, content) {[weak self] results in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch results {
            case .success(let newList):
                self.todoLists.append(newList.results)
                let lastList = self.todoLists.filter { $0.id == newList.results.id }.map { ToDoListPresentation(title: $0.title, content: $0.content )}
                self.presentation += lastList
                self.notify(.showToDoLists(self.presentation))
                self.notify(.showSuccessAdded(true))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleToDoListViewModelOutput(output)
    }
}
