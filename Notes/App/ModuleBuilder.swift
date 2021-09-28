//
//  ModuleBuilder.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import CoreData
import UIKit

class ModuleBuilder {
    static let shared = ModuleBuilder()
    private init() { }
    
    var coreDataContext: NSManagedObjectContext!
    
    func createNotesModule() -> UIViewController {
//        let notesRepository = CoreDataRepository
        let notesRepository = NotesRepository()
        let presenter = NotesPresenter(repository: notesRepository)
        
        let viewController = NotesTableVC()
        viewController.presenter = presenter
        presenter.view = viewController
        
        let navigationController = createNavigationController(for: viewController, titled: "Notes")
        
        return navigationController
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            titled title: String) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.title = title
        return navigationController
        
    }
}
