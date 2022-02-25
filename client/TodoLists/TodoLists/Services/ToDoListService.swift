//
//  ToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

struct ToDoListService: IToDoListService {
    
    func getLists(completion: @escaping (Result<ListResponse<[List]>>) -> Void)
    {
        NetworkManager.shared.request(request: .allLists,
                                      responseModel: ListResponse<[List]>.self) { (results) in
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
                 completion: @escaping (Result<ListResponse<List>>) -> Void)
    {
        NetworkManager.shared.request(request: .addList(title,
                                                        content),
                                      responseModel: ListResponse<List>.self) { (result) in
            switch result {
            case .success(let newList):
                print(newList)
                completion(.success(newList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteList(with id: UUID,
                    completion: @escaping (Result<Bool>) -> Void)
    {
        NetworkManager.shared.request(request: .deleteList(id: id)) { (result) in
            switch result {
            case .success(let isDeleted):
                completion(.success(isDeleted))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateList(with id: UUID,
                    title: String,
                    content: String,
                    isCompleted: Bool,
                    completion: @escaping (Result<ListResponse<List>>) -> Void)
    {
        NetworkManager.shared.request(request: .updateList(id: id,
                                                           title,
                                                           content,
                                                           isCompleted),
                                      responseModel: ListResponse<List>.self) { (result) in
            switch result {
            case .success(let updatedList):
                completion(.success(updatedList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
