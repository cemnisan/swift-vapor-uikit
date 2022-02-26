//
//  AddListViewModel.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import Foundation

final class AddListViewModel: AddListViewModelProtocol
{
    var delegate: AddListViewModelDelegate?
    private let service: IToDoListService
    
    init(service: IToDoListService) {
        self.service = service
    }
}

extension AddListViewModel
{
    func add(with title: String,
             content: String,
             expectedDate: String,
             selectedDate: String) throws {
  
        if (title.isEmpty)   { throw EmptyError.isTitleEmpty }
        if (content.isEmpty) { throw EmptyError.isContentEmpty }
        if (selectedDate.isEmpty) { throw EmptyError.isDateEmpty }
        
        notify(.setLoading(true))
        
        service.addList(with: title,
                        content,
                        expectedDate) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(_):
                self.notify(.showSuccessAdded(true))
            case .failure(let error):
                self.notify(.showError(error))
            }
        }
    }
    
    func notify(_ output: AddListViewModelOutput) {
        delegate?.handleOutput(output)
    }
}
