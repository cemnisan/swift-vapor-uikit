//
//  ToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

struct ToDoListService: IToDoListService {
    
    func getLists(completion: @escaping (Result<ListResponse>) -> Void)  {
        NetworkManager.shared.request(
            request: .allLists,
            responseModel: ListResponse.self
        ) { (results) in
            switch results {
            case .success(let lists):
                completion(.success(lists))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addList(with title: String,
                  _ content: String,
                  completion: @escaping (Result<NewListResponse>) -> Void) {
        NetworkManager.shared.request(
            request: .addList(title, content),
            responseModel: NewListResponse.self) { (results) in
            switch results {
            case .success(let newList):
                completion(.success(newList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
