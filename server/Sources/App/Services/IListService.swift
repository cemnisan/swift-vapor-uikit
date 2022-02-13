//
//  File.swift
//  
//
//  Created by Cem Nisan on 13.02.2022.
//

import Vapor
import Fluent

protocol IListService {
    
    func getAllList(from db: Database) throws -> EventLoopFuture<[List]>
    
    func getList(with id: UUID,
                 from db: Database) throws -> EventLoopFuture<List>
    
    func creaeteList( with decodedList: List,
                      to db: Database) throws -> EventLoopFuture<List>
    
    func updateList(with id: UUID,
                    _ decodedList: List,
                    from db: Database) throws -> EventLoopFuture<List>
    
    func deleteList(with id: UUID,
                    from db: Database) throws -> EventLoopFuture<HTTPStatus>
}
