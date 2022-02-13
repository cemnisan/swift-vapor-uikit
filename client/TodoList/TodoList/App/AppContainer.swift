//
//  AppContainer.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation
import TodoListAPI

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service = ListClient()
}
