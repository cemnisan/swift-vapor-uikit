//
//  AppContainer.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

final class AppContainer {
    static let shared = AppContainer()
    
    let router = AppRouter()
    let service = ToDoListService()
}
