//
//  ListResponse.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

public struct ListResponse<T>: Codable where T: Codable {
    
    public let result: T
    public let statusCode: Int
    
    init(result: T, statusCode: Int) {
        self.result = result
        self.statusCode = statusCode
    }
}
