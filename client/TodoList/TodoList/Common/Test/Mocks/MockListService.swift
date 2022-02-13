//
//  MockListService.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation
@testable import TodoListAPI

final class MockListService: ListClientProtocol {
    var lists: [List] = []
    
    func fetchAllLists(completion: @escaping (Result<ListResponse>) -> Void) {
        completion(.success(ListResponse(results: lists)))
    }
}
