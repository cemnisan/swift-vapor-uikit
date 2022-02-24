//
//  File.swift
//  
//
//  Created by Cem Nisan on 10.02.2022.
//

import Vapor
import Fluent


struct ListService: IListService {
    
    func get(from db: Database) throws -> EventLoopFuture<[List]> {
        return List.query(on: db).all()
    }
    
    func get(with id: UUID,
                 from db: Database) throws -> EventLoopFuture<List> {
        return List.find(id, on: db).unwrap(or: Abort(.notFound))
    }
    
    func create(with decodedList: List,
                     to db: Database) throws -> EventLoopFuture<List> {
        return decodedList.save(on: db).map { decodedList }
    }
    
    func update(with id: UUID,
                    _ decodedList: List,
                    from db: Database) throws -> EventLoopFuture<List> {
        return List
            .find(id, on: db)
            .unwrap(or: Abort(.notFound))
            .flatMap { list in
                list.title = decodedList.title
                list.content = decodedList.content
                
                return list.save(on: db).map { list }
            }
    }
    
    func delete(with id: UUID,
                    from db: Database) throws -> EventLoopFuture<DeleteResponse> {
        return List
            .find(id, on: db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: db) }
            .map { DeleteResponse(results: "Has Been Deleted.", statusCode: .ok) }
    }
}

