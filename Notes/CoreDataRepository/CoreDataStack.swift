//
//  CoreDataStack.swift
//  HandicapCalculator
//
//  Created by Артём on 19.09.2021.
//

import CoreData

protocol CoreDataContextProvider {
    var viewContext: NSManagedObjectContext { get }
    func performBackgroundTask(_: @escaping (NSManagedObjectContext) -> Void)
    func saveContext()
}

class CoreDataStack: CoreDataContextProvider {
    private let objectModelName: String

    init(modelName: String) {
        objectModelName = modelName
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: objectModelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = persistentContainer.viewContext
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    func saveContext() {
        let context = viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
