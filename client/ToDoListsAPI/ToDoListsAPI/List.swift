//
//  List.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

public struct List: Codable {
    public enum CodingKeys: String, CodingKey {
        case title
        case content
        case isCompleted
        case id
    }
    
    public let title:String
    public let content: String
    public let isCompleted: Bool
    public let id: UUID
}
