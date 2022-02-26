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

// MARK: - View Model Protocol
extension AddListViewModel
{
    func add(with title: String,
             content: String,
             expectedDate: String,
             selectedDate: String)
    {
        do {
            try validate(with: title, content, expectedDate)
            
            notify(.setLoading(true))
            
            service.addList(with: title,
                            content,
                            selectedDate) { [weak self] (result) in
                guard let self = self else { return }
                self.notify(.setLoading(false))
                
                switch result {
                case .success(_):
                    self.notify(.showSuccessAdded(true))
                case .failure(let networkError):
                    self.notify(.showError(networkError))
                }
            }
        } catch let validateError {
            notify(.showError(validateError))
        }
    }
    
    func notify(_ output: AddListViewModelOutput) {
        delegate?.handleOutput(output)
    }
}

// MARK: - Validate
extension AddListViewModel {
    private func validate(with title:String,
                          _ content: String,
                          _ expectedDate: String) throws {
        guard !title.isEmpty else {
            throw ValidateError.isTitleEmpty
        }
        
        guard title.count >= 3 else {
            throw ValidateError.isTitleTooShort
        }
        
        guard title.count < 15 else {
            throw ValidateError.isTitleTooLong
        }
    
        guard !content.isEmpty else {
            throw ValidateError.isContentEmpty
        }
        
        guard content.count > 3 else {
            throw ValidateError.isContentTooShort
        }

        guard !expectedDate.isEmpty else {
            throw ValidateError.isDateEmpty
        }
    }
}
