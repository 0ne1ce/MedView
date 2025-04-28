//
//  ParametersWorker.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersWorker {
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    private let isFirstEntrancePassedKey = "isFirstEntrancePassed"
    
    func checkFirstLaunch() -> Bool {
        if !defaults.bool(forKey: isFirstEntrancePassedKey) {
            defaults.set(true, forKey: isFirstEntrancePassedKey)
            return true
        }
        return false
    }
}
