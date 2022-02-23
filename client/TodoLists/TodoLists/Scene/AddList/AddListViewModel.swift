//
//  AddListViewModel.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import Foundation

final class AddListViewModel: AddListViewModelProtocol {
    var delegate: AddListViewModelDelegate?
    private let service: IToDoListService
    
    init(service: IToDoListService) {
        self.service = service
    }
    
    func add(with title: String, _ content: String) {
        notify(.setLoading(true))
        
        service.addList(with: title, content) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(_):
                self.notify(.showSuccessAdded(true))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func notify(_ output: AddListViewModelOutput) {
        delegate?.handleOutput(output)
    }
}
