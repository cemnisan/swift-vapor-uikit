//
//  IToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

protocol IToDoListService {
    func getLists(completion: @escaping (Result<ListResponse<[List]>>) -> Void)
    
    func addList(with title: String,
                 _ content: String,
                 _ endDate: String,
                 completion: @escaping (Result<ListResponse<List>>) -> Void)
    
    func deleteList(with id: UUID,
                    completion: @escaping (Result<Bool>) -> Void)
    
    func updateList(with id: UUID,
                    title: String,
                    content: String,
                    isCompleted: Bool,
                    completion: @escaping  (Result<ListResponse<List>>) -> Void)
}
