//
//  BloodPressureExtension.swift
//  MedView
//
//  Created by Алексей on 17.04.2025.
//

import UIKit

extension StepActivity: MedParameterData {
    var numericValue: Double {
        return Double(self.value)
    }
    
    var timeStamp: Date {
        return self.date ?? Date()
    }
}
