//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.02.2022.
//

import Vapor
import Fluent
import NIOHTTP2

final class List: Model {
    
    static let schema = "lists"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    @OptionalField(key: "isCompleted")
    var isCompleted: Bool?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil,
         title: String,
         content: String,
         isCompleted: Bool = false,
         createdAt: Date?,
         updatedAt: Date?
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


extension List: Content { }
