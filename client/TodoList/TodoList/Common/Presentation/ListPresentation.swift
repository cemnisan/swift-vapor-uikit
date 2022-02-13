//
//  ListPresentation.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation

final class ListPresentation: NSObject {
    let title: String
    let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        super.init()
    }
}
