//
//  ListResponse.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

public struct ListResponse: Codable {
    public let results: [List]
    
    init(results: [List]) {
        self.results = results
    }
}

public struct NewListResponse: Codable {
    public let results: List
    
    init(results: List) {
        self.results = results
    }
}

public struct DeleteResponse: Codable {
    public let results: String
    public let statusCode: Int
    
    init(results: String, statusCode: Int) {
        self.results = results
        self.statusCode = statusCode
    }
}
