//
//  ParametersColors.swift
//  MedView
//
//  Created by Алексей on 12.02.2025.
//

import Foundation
import UIKit

enum MedParameterType: String, CaseIterable {
    case step = "Step activity"
    case pulse = "Pulse"
    case saturation = "Saturation"
    case sleepHours = "Sleep hours"
    case stressLevel = "Stress level"
    case temperature = "Temperature"
    case weight = "Weight"
    case bloodGlucose = "Blood glucose"
}
