//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.02.2022.
//

import Fluent

struct CreateList: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("lists")
            .id()
            .field("title",
                   .string,
                   .required)
            .field("content",
                   .string,
                   .required)
            .field("isCompleted",
                   .bool,
                   .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("lists").delete()
    }
}
