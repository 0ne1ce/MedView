//
//  SettingsWorker.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class CardWorker {
    // MARK: - Constants
    private enum Constants {
        static let bloodGroupKey: String = "bloodGroup"
        static let allergiesKey: String = "allergies"
        static let chronicDiseasesKey: String = "chronicDiseases"
    }
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Functions
    func saveBloodGroup(_ bloodGroup: String) {
        defaults.set(bloodGroup, forKey: Constants.bloodGroupKey)
    }
    
    func loadBloodGroup() -> String {
        return defaults.string(forKey: Constants.bloodGroupKey) ?? ""
    }
    
    func saveAllergies(_ allergies: String) {
        defaults.set(allergies, forKey: Constants.allergiesKey)
    }
    
    func loadAllergies() -> String {
        return defaults.string(forKey: Constants.allergiesKey) ?? ""
    }
    
    func saveChronicDiseases(_ chronicDiseases: String) {
        defaults.set(chronicDiseases, forKey: Constants.chronicDiseasesKey)
    }
    
    func loadChronicDiseases() -> String {
        return defaults.string(forKey: Constants.chronicDiseasesKey) ?? ""
    }
}
