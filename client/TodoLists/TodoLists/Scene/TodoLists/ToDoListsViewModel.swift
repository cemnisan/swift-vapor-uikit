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
}

extension ToDoListViewModel {
    
    func load(with segmenTitle: SelectSegmentTitle) {
        notify(.setLoading(true))
        
        service.getLists { [weak self] results in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch results {
            case .success(let lists):
                self.todoLists = lists.results
                let presentation = self.filterData(with: segmenTitle)
                self.notify(.showToDoLists(presentation))
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
                let addedList = ToDoListPresentation(list: newList.results)
                self.notify(.showSuccessAdded(true, addedList))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleToDoListViewModelOutput(output)
    }
    
    private func filterData(with segmenTitle: SelectSegmentTitle) -> [ToDoListPresentation] {
        var presentation: [ToDoListPresentation] = []
        
        switch segmenTitle {
        case .completed:
            presentation += todoLists.filter { $0.isCompleted == true }.map { ToDoListPresentation(list: $0)}
            return presentation
        case .notCompleted:
            presentation += todoLists.filter { $0.isCompleted != true }.map { ToDoListPresentation(list: $0)}
            return presentation
        }
    }
}
