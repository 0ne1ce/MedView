//
//  MedParameterData.swift
//  MedView
//
//  Created by Алексей on 17.04.2025.
//

import UIKit
import CoreData

protocol MedParameterData: NSManagedObject {
    var numericValue: Double { get }
    var timeStamp: Date { get }
}
