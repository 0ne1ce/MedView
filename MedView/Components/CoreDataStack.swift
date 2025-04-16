//
//  CoreDataStack.swift
//  MedView
//
//  Created by Алексей on 16.04.2025.
//

import CoreData

final class CoreDataStack {
    // MARK: - Properties
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HealthModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Functions
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
