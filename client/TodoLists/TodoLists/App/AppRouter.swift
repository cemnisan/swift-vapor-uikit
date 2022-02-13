//
//  AppRouter.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
}

extension AppRouter {
    func start(with windowScene: UIWindowScene) {
        let viewController = ToDoListsBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.windowScene = windowScene
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
