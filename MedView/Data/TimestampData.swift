//
//  NotificationData.swift
//  MedView
//
//  Created by Алексей on 27.04.2025.
//

import UIKit
import CoreData

protocol TimestampData: NSManagedObject {
    var timestampValue: String { get set }
    var repeatStatusEnabled: Bool { get set }
}
