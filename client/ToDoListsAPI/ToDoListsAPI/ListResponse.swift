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
