//
//  IToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

protocol IToDoListService {
    func getLists(completion: @escaping (Result<ListResponse>) -> Void)
    func addList(with title: String, _ content: String, completion: @escaping (Result<NewListResponse>) -> Void)
}
