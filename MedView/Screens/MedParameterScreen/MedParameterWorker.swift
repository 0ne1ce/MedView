//
//  MedParameterWorker.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import UIKit
import Foundation
import CoreData

final class MedParameterWorker {
    // MARK: - Properties
    private let context = CoreDataStack.shared.context
    
    // MARK: - Functions
    func saveParameterData<T: MedParameterData>(type: T.Type, value: Double, date: Date) {
        let entity = T(context: context)
        entity.setValue(value, forKey: "value")
        entity.setValue(date, forKey: "date")
        
        CoreDataStack.shared.saveContext()
    }
    
    func loadParameterData<T: MedParameterData>(type: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteParameterData<T: MedParameterData>(type: T.Type) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        guard (try? context.execute(deleteRequest)) != nil else {
            return
        }
        CoreDataStack.shared.saveContext()
    }
}
