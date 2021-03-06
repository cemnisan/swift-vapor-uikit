//
//  List.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

public struct List: Codable {

    public let id: UUID
    public let title:String
    public let content: String
    public let isCompleted: Bool
    public let createdAt: Date
    public let updatedAt: Date
    public let endDate: Date
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case isCompleted
        case createdAt
        case updatedAt
        case endDate
    }
}


