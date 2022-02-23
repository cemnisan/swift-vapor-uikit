//
//  File.swift
//  
//
//  Created by Cem Nisan on 13.02.2022.
//

import Vapor
import Fluent

protocol IListService {
    
    func get(from db: Database) throws -> EventLoopFuture<[List]>
    
    func get(with id: UUID,
                 from db: Database) throws -> EventLoopFuture<List>
    
    func create(with decodedList: List,
                      to db: Database) throws -> EventLoopFuture<List>
    
    func delete(with id: UUID,
                    from db: Database) throws -> EventLoopFuture<HTTPStatus>
    
    func update(with id: UUID,
                    _ decodedList: List,
                    from db: Database) throws -> EventLoopFuture<List>
}
