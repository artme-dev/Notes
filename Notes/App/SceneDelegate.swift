//
//  SceneDelegate.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let builder = ModuleBuilder.shared
        
        let window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        window.rootViewController = builder.createNotesModule()
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.сontextProvider.saveContext()
    }
}
