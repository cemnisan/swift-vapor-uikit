//
//  SceneDelegate.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        AppContainer.shared.router.start(with: windowScene)
    }
}

