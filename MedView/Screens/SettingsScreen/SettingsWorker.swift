//
//  SettingsWorker.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsWorker {
    // MARK: - Constants
    private enum Constants {
        static let isSettingsInitialized: String = "isSettingsInitialized"
        static let customNotificationsKey: String = "customNotifications"
        static let themeSwitchState: String = "themeSwitchState"
        static let defaultNotificatonsSwitchStatesKey: String = "defaultNotificationsStates"
        static let customNotificatonsSwitchStatesKey: String = "defaultNotificationsStates"
    }
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    
    // MARK: - Initialization
    init() {
        guard !defaults.bool(forKey: Constants.isSettingsInitialized) else {
            return
        }
        if !defaults.bool(forKey: Constants.isSettingsInitialized) {
            defaults.set([false, false, false], forKey: Constants.defaultNotificatonsSwitchStatesKey)
            defaults.set(false, forKey: Constants.themeSwitchState)
            defaults.set(true, forKey: Constants.isSettingsInitialized)
        }
    }
    
    // MARK: - Functions
    func saveCustomNotifications(_ notifications: [String]) {
        defaults.set(notifications, forKey: Constants.customNotificationsKey)
    }
    
    func loadCustomNotifications() -> [String] {
        return defaults.stringArray(forKey: Constants.customNotificationsKey) ?? []
    }
    
    func saveThemeState(_ isDarkThemeState: Bool) {
        defaults.set(isDarkThemeState, forKey: Constants.themeSwitchState)
    }
    
    func loadThemeState() -> Bool {
        return defaults.bool(forKey: Constants.themeSwitchState)
    }
    
    func saveDefaultNotificationsStates(_ switchStates: [Bool]) {
        defaults.set(switchStates, forKey: Constants.defaultNotificatonsSwitchStatesKey)
    }
    
    func loadDefaultNotificationsStates() -> [Bool] {
        return defaults.array(forKey: Constants.defaultNotificatonsSwitchStatesKey) as? [Bool] ?? []
    }
    
    func saveCustomNotificationsStates(_ switchStates: [Bool]) {
        defaults.set(switchStates, forKey: Constants.customNotificatonsSwitchStatesKey)
    }
    
    func loadCustomNotificationsStates() -> [Bool] {
        return defaults.array(forKey: Constants.customNotificatonsSwitchStatesKey) as? [Bool] ?? []
    }
}
