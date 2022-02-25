//
//  ListPresentation.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

final class ToDoListPresentation: NSObject {
    let id: UUID
    let title: String
    let content: String
    let isCompleted: Bool
    let createdAt: String
    let updatedAt: String
    
    init(
        list: List
    ) {
        self.id = list.id
        self.title = list.title
        self.content = list.content
        self.isCompleted = list.isCompleted
        self.createdAt = list.createdAt
        self.updatedAt = list.updatedAt
        
        super.init()
    }
}
