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
        case id
    }

   public let title:String
   public let content: String
   public let id: UUID
}
