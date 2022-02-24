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
    
    func getAllLists(_ req: Request) throws -> EventLoopFuture<ListResponse<[List]>> {
        let allLists = try service.get(from: req.db)
        
        // return JSON.
        return allLists.map { lists in
            ListResponse<[List]>(results: lists, statusCode: .ok)
        }
    }
    
    func getListById(_ req: Request) throws -> EventLoopFuture<ListResponse<List>> {
        guard let listID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let foundList = try service.get(with: listID, from: req.db)
        
        return foundList.map { list in
            ListResponse<List>(results: list, statusCode: .ok)
        }
    }
    
    func createList(_ req: Request) throws -> EventLoopFuture<ListResponse<List>> {
        let decodedList = try req.content.decode(List.self)
        let createdList = try service.create(with: decodedList, to: req.db)

        return createdList.map { newList in
            ListResponse<List>(results: newList, statusCode: .created)
        }
    }
    
    func updateListById(_ req: Request) throws -> EventLoopFuture<ListResponse<List>> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let decodedList = try req.content.decode(List.self)
        let updatedList = try service.update(with: id, decodedList, from: req.db)
        
        return updatedList.map { list in
            ListResponse<List>(results: list, statusCode: .ok)
        }
    }
    
    func deleteListById(_ req: Request) throws -> EventLoopFuture<DeleteResponse> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let deletedList = try service.delete(with: id, from: req.db)
 
        return deletedList.map { return $0 }
    }
}

struct DeleteResponse: Content {
    let results: String
    let statusCode: HTTPStatus
    
    init(results: String, statusCode: HTTPStatus) {
        self.results = results
        self.statusCode = statusCode
    }
}
