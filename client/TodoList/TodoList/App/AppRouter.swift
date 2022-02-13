//
//  AppRouter.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start(windowScene: UIWindowScene) {
        let viewController = ListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.windowScene = windowScene
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
