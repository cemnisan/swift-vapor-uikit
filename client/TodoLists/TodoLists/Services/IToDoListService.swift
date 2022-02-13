//
//  IToDoListService.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

protocol IToDoListService {
    func getAllLists(completion: @escaping (Result<ListResponse>) -> Void)
}
