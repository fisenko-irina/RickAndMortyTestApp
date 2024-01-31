//
//  SceneDelegate.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let controller = SplashScreen()
        
        let navigationController = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
