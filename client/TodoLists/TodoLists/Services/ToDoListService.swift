//
//  ToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

struct ToDoListService: IToDoListService {
    func getAllLists(completion: @escaping (Result<ListResponse>) -> Void)  {
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
}
