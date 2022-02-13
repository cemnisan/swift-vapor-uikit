//
//  List.swift
//  TodoListAPI
//
//  Created by Cem Nisan on 11.02.2022.
//

import Foundation

public struct List: Decodable {
    
    public enum codingKeys: String, CodingKey {
        case title
        case content
        case id
    }
    
    public let title: String
    public let content: String
    public let id: UUID
}
