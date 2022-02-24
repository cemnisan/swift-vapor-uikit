//
//  ToDoListsViewModel.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import UIKit
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
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.notify(.setLoading(false))
                
                switch results {
                case .success(let lists):
                    self.todoLists = lists.results
                    let presentation = self.filterData(with: segmenTitle, list: self.todoLists)
                    print("load \(self.todoLists)")
                    self.notify(.showToDoLists(presentation))
                case .failure(let error):
                    self.notify(.showError(error))
                }
            }
        }
    }
    
    func delete(with id: UUID, _ segmentTitle: SelectSegmentTitle) {
        notify(.setLoading(true))
        
        service.deleteList(with: id) { [weak self] (results) in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.notify(.setLoading(false))
                
                switch results {
                case .success(_):
                    self.todoLists = self.todoLists.filter { $0.id != id }
                    let newList = self.filterData(with: .notCompleted, list: self.todoLists)
                    print("deleted: \(self.todoLists)")
                    self.notify(.showToDoLists(newList))
                    self.notify(.successDelete(true))
                case .failure(let error):
                    self.notify(.showError(error))
                }
            }
        }
    }
    
    func selectAddButton() {
        let viewModel = AddListViewModel(service: service)
        delegate?.navigate(to: .add(viewModel))
    }
    
    private func notify(_ output: ToDoListViewModelOutput) {
        delegate?.handleToDoListViewModelOutput(output)
    }
    
    private func filterData(with segmenTitle: SelectSegmentTitle, list: [List]) -> [ToDoListPresentation] {
        var presentation: [ToDoListPresentation] = []
        
        switch segmenTitle {
        case .completed:
            presentation += list.filter { $0.isCompleted == true }.map { ToDoListPresentation(list: $0)}
            return presentation
        case .notCompleted:
            presentation += list.filter { $0.isCompleted != true }.map { ToDoListPresentation(list: $0)}
            return presentation
        }
    }
}
