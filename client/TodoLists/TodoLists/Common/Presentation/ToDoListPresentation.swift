//
//  ListPresentation.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

final class ToDoListPresentation: NSObject {
    let title: String
    let content: String
    
    init(
        title: String,
        content: String
    ) {
        self.title = title
        self.content = content
        
        super.init()
    }
}
