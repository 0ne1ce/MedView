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
    func saveTimestampData<T: TimestampData>(type: T.Type, time: String, repeatStatus: Bool) {
        let entity = T(context: context)
        entity.setValue(time, forKey: "time")
        entity.setValue(repeatStatus, forKey: "repeatStatus")
        
        CoreDataStack.shared.saveContext()
    }
    
    func loadTimestampsData<T: TimestampData>(type: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteTimestampData<T: TimestampData>(type: T.Type, time: String, repeatStatus: Bool) {
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
    
    func loadCustomNotification(id: Int) -> CustomNotification? {
        let request: NSFetchRequest<CustomNotification> = CustomNotification.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", id as CVarArg)
        return try? context.fetch(request).first
    }
    
    func saveCustomTimestamp(notificationId: Int, time: String, repeatStatus: Bool) {
        guard let notification = loadCustomNotification(id: notificationId) else { return }
        
        let newTimestamp = CustomTimestamp(context: context)
        newTimestamp.time = time
        newTimestamp.repeatStatus = repeatStatus
        newTimestamp.notification = notification
        
        CoreDataStack.shared.saveContext()
    }
    
    func loadTimestamps(for notificationId: Int) -> [CustomTimestamp] {
        guard let notification = loadCustomNotification(id: notificationId),
              let timestamps = notification.timestamps as? Set<CustomTimestamp> else {
            return []
        }
        return Array(timestamps).sorted { $0.time ?? "" < $1.time ?? "" }
    }
    
    func deleteCustomTimestamp(notificationId: Int, time: String, repeatStatus: Bool) {
        let request: NSFetchRequest<CustomTimestamp> = CustomTimestamp.fetchRequest()
        request.predicate = NSPredicate(format: "notification.id == %d AND time == %@ AND repeatStatus == %@",
                                        notificationId, time, NSNumber(value: repeatStatus))
        request.fetchLimit = 1
        
        do {
            if let timestamp = try context.fetch(request).first {
                context.delete(timestamp)
                CoreDataStack.shared.saveContext()
            }
        } catch {
            print("Failed to delete custom timestamp: \(error)")
        }
    }

}
