//
//  AppDelegate.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let сontextProvider: CoreDataContextProvider = CoreDataStack(modelName: "Notes")
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let builder = ModuleBuilder.shared
        builder.coreDataContext = сontextProvider.viewContext
        
        return true
    }
}
