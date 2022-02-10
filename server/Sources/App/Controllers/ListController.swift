//
//  File.swift
//  
//
//  Created by Cem Nisan on 9.02.2022.
//

import Vapor

final class ListController {
    var service: IListService
    
    init(service: IListService) {
        self.service = service
    }
}

extension ListController {
    func getAllLists(_ req: Request) -> EventLoopFuture<[List]> {
        let allLists = service.getAllList(from: req.db)
        
        return allLists
    }
    
    func getListById(_ req: Request) throws -> EventLoopFuture<List> {
        guard let listID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let list = service.getList(with: listID, from: req.db)
        
        return list
    }
    
    func createList(_ req: Request) throws -> EventLoopFuture<List> {
        let decodedList = try req.content.decode(List.self)
        let createdList = try service.creaeteList(with: decodedList, to: req.db)

        return createdList
    }
    
    func updateListById(_ req: Request) throws -> EventLoopFuture<List> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let decodedList = try req.content.decode(List.self)
        let updatedList = service.updateList(with: id, decodedList, from: req.db)
        
        return updatedList
    }
    
    func deleteListById(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let deletedList = service.deleteList(with: id, from: req.db)
        
        return deletedList
    }
}
