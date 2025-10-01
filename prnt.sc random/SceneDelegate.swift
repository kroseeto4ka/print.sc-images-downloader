//
//  SceneDelegate.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 6/18/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let warningVC = WarningViewController()
        let navigationController = UINavigationController(rootViewController: warningVC)
        let warningAssembly = WarningAssembly(navigationController: navigationController)
        warningAssembly.configure(viewController: warningVC)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }


}

