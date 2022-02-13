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
    
    init() { }
    
    init(id: UUID? = nil,
         title: String,
         content: String
    ) {
        self.id = id
        self.title = title
        self.content = content
    }
}


extension List: Content { }
