//
//  ListPresentation.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import ToDoListsAPI

final class ToDoListPresentation: NSObject {
    let title: String
    let content: String
    let isCompleted: Bool
    
    init(
        list: List
    ) {
        self.title = list.title
        self.content = list.content
        self.isCompleted = list.isCompleted
        
        super.init()
    }
}
