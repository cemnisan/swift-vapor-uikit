//
//  ListResponse.swift
//  TodoListAPI
//
//  Created by Cem Nisan on 11.02.2022.
//

import Foundation

public struct ListResponse: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public let results: [List]
    
    init(results: [List]) {
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try rootContainer.decode([List].self, forKey: .results)
    }
}
