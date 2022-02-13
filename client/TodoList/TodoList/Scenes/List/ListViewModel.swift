//
//  ListViewModel.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation
import TodoListAPI

final class ListViewModel: ListViewModelProtocol {
    weak var delegate: ListViewModelDelegate?
    private let service: ListClientProtocol
    private var lists: [List] = []
    
    init(service: ListClientProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("Lists"))
        notify(.setLoading(true))
        
        service.fetchAllLists { [weak self] (result) in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(let response):
                self.lists = response.results
                let presentations = self.lists.map({ ListPresentation(title: $0.title, content: $0.content) })
                self.notify(.showList(presentations))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectList(at index: Int) {
        let list = lists[index]
        let viewModel = ListDetailViewModel(list: list)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(_ output: ListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
