//
//  File.swift
//  
//
//  Created by Cem Nisan on 9.02.2022.
//

import Vapor

final class ListController {
    func getAllLists(_ req: Request) -> EventLoopFuture<[List]> {
       return List.query(on: req.db).all()
    }
    
    func getListById(_ req: Request) -> EventLoopFuture<List> {
        return List
            .find(req.parameters.get("id"),
                             on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func createList(_ req: Request) throws -> EventLoopFuture<List> {
        let list = try req.content.decode(List.self)
        
        return list.save(on: req.db).map {
            list
        }
    }
    
    func updateListById(_ req: Request) throws -> EventLoopFuture<List> {
        let updatedList = try req.content.decode(List.self)
        
        return List.find(
                req.parameters.get("id"),
                on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { list in
                list.title = updatedList.title
                list.content = updatedList.content
                return list.save(on: req.db).map {
                    list
                }
            }
    }
    
    func deleteListById(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        return List.find(
                req.parameters.get("id"),
                on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { list in
                list.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
}
