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
    func savePulse(value: Double, date: Date) {
        let pulseEntry = Pulse(context: context)
        pulseEntry.value = Int64(value)
        pulseEntry.date = date
        
        CoreDataStack.shared.saveContext()
    }
    
    func loadPulse() -> [Pulse] {
        let request: NSFetchRequest<Pulse> = Pulse.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return (try? context.fetch(request)) ?? []
    }
    
    func deletePulseData() {
        let request: NSFetchRequest<NSFetchRequestResult> = Pulse.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        guard (try? context.execute(deleteRequest)) != nil else {
            return
        }
        CoreDataStack.shared.saveContext()
    }
}
