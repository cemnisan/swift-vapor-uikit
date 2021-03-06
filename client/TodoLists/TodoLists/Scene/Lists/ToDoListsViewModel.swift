//
//  ToDoListsViewModel.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import UIKit
import ToDoListsAPI

final class ToDoListViewModel: ToDoListViewModelProtocol
{
    weak var delegate: ToDoListViewModelDelegate?
    private let service: IToDoListService
    private var todoLists: [List] = []
    
    init(service: IToDoListService) {
        self.service = service
    }
}

// MARK: - View Model Protocol
extension ToDoListViewModel
{
    func load(with segmenTitle: SelectSegmentTitle)
    {
        notify(.setLoading(true))
        
        service.getLists { [weak self] results in
            guard let self = self else { return }
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.notify(.setLoading(false))
                
                switch results {
                case .success(let lists):
                    self.todoLists = lists.result
                    let lists = self.filterData(with: self.todoLists, segmenTitle)
                    self.notify(.showToDoLists(lists))
                case .failure(let error):
                    self.notify(.showError(error))
                }
            }
        }
    }
    
    func delete(
        with id: UUID,
        _ segmentTitle: SelectSegmentTitle
    ) {
        notify(.setLoading(true))
        
        service.deleteList(with: id) { [weak self] (results) in
            guard let self = self else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.notify(.setLoading(false))
                
                switch results {
                case .success(let isDeleted):
                    self.todoLists = self.todoLists.filter { $0.id != id }
                    let newList = self.filterData(with: self.todoLists, segmentTitle)
                    self.notify(.showToDoLists(newList))
                    self.notify(.successDelete(isDeleted))
                case .failure(let error):
                    self.notify(.showError(error))
                }
            }
        }
    }
    
    func updateList(
        with id: UUID,
        title: String,
        content: String,
        isCompleted: Bool
    ) {
        notify(.setLoading(true))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.service.updateList(with: id,
                               title: title,
                               content: content,
                               isCompleted: isCompleted) { [weak self] (result) in
                
                guard let self = self else { return }
                self.notify(.setLoading(false))
                
                switch result {
                case .success(let updatedList):
                    for index in self.todoLists.indices {
                        if self.todoLists[index].id == id {
                            self.todoLists[index] = updatedList.result
                        }
                    }
                    let updatedList = self.filterData(with: self.todoLists, .notCompleted)
                    
                    self.notify(.showToDoLists(updatedList))
                    self.notify(.successUpdate(true))
                case .failure(let error):
                    self.notify(.showError(error))
                }
            }
        }
    }
    
    func selectAddButton()
    {
        let viewModel = AddListViewModel(service: service)
        delegate?.navigate(to: .add(viewModel))
    }

}

// MARK: - Filter Data
extension ToDoListViewModel
{
    private func filterData(with list: [List],
                            _ segmenTitle: SelectSegmentTitle) -> [ToDoListPresentation]
    {
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
    
    private func notify(_ output: ToDoListViewModelOutput)
    {
        delegate?.handleToDoListViewModelOutput(output)
    }
}
