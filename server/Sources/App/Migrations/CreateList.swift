//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.02.2022.
//

import Fluent

struct CreateList: Migration
{
    func prepare(on database: Database) -> EventLoopFuture<Void>
    {
        database.schema("lists")
            .id()
            .field("title",
                   .string)
            .field("content",
                   .string)
            .field("isCompleted",
                   .bool)
            .field("endDate",
                   .date)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void>
    {
        database.schema("lists").delete()
    }
}
