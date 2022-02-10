//
//  File.swift
//  
//
//  Created by Cem Nisan on 10.02.2022.
//

import Vapor
import Fluent

protocol IListService {
    func getAllList(
        from db: Database
    ) -> EventLoopFuture<[List]>
    
    func getList(
        with id: UUID,
        from db: Database
    ) -> EventLoopFuture<List>
    
    func creaeteList(
        with decodedList: List,
        to db: Database
    ) throws -> EventLoopFuture<List>
    
    func updateList(
        with id: UUID,
        _ decodedList: List,
        from db: Database
    ) -> EventLoopFuture<List>
    
    func deleteList(
        with id: UUID,
        from db: Database
    ) -> EventLoopFuture<HTTPStatus>
}

struct ListService: IListService {
    func getAllList(
        from db: Database
    ) -> EventLoopFuture<[List]> {
        return List.query(on: db).all()
    }
    
    func getList(
        with id: UUID,
        from db: Database
    ) -> EventLoopFuture<List> {
        return List.find(id, on: db).unwrap(or: Abort(.notFound))
    }
    
    func creaeteList(
        with decodedList: List,
        to db: Database
    ) throws -> EventLoopFuture<List> {
        return decodedList.save(on: db).map { decodedList }
    }
    
    func updateList(
        with id: UUID,
        _ decodedList: List
        , from db: Database
    ) -> EventLoopFuture<List> {
        return List
            .find(id, on: db)
            .unwrap(or: Abort(.notFound))
            .flatMap { list in
                list.title = decodedList.title
                list.content = decodedList.content
                
                return list.save(on: db).map { list }
            }
    }
    
    func deleteList(
        with id: UUID,
        from db: Database
    ) -> EventLoopFuture<HTTPStatus> {
        return List
            .find(id, on: db)
            .unwrap(or: Abort(.notFound))
            .flatMap { list in
                list
                    .delete(on: db)
                    .transform(to: .noContent)
        }
    }
}
