//
//  SettingsWorker.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit
import CoreData

final class NotificationWorker {
    // MARK: - Properties
    private let context = CoreDataStack.shared.context
    
    // MARK: - Functions
    func saveTimestampsData<T: TimestampData>(type: T.Type, time: String, repeatStatus: Bool) {
        let entity = T(context: context)
        entity.setValue(time, forKey: "time")
        entity.setValue(repeatStatus, forKey: "repeatStatus")
        
        CoreDataStack.shared.saveContext()
    }
    
    func loadTimestampsData<T: TimestampData>(type: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteTimestampsData<T: TimestampData>(type: T.Type, time: String, repeatStatus: Bool) {
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else {
            print("Failed to create fetch request for \(T.self)")
                    return
        }
        request.predicate = NSPredicate(format: "time == %@ AND repeatStatus == %@", time, NSNumber(value: repeatStatus))
        
        do {
            let results = try context.fetch(request)
            for object in results {
                context.delete(object)
            }
            CoreDataStack.shared.saveContext()
        } catch {
            print("Failed to delete timestamp data: \(error)")
        }
    }

}
