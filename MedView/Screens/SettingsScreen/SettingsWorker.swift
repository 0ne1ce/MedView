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
        static let drinkNotificationsIdsKey: String = "drinkNotificationsIds"
        static let foodNotificationsIdsKey: String = "foodNotificationsIds"
        static let sleepNotificationsIdKey: String = "sleepNotificationsId"
        
        static let customNotificatonsSwitchStatesKey: String = "customNotificationsStates"
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
    
    func enableDrinkNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Stay hydrated 🥤"
        content.body = "It's your reminder to drink water and be healthy!"
        content.sound = .default
        
        let dailySchedule: [DateComponents] = [
            DateComponents(hour: 9, minute: 0),
            DateComponents(hour: 11, minute: 30),
            DateComponents(hour: 14, minute: 0),
            DateComponents(hour: 16, minute: 30),
            DateComponents(hour: 19, minute: 0),
            DateComponents(hour: 21, minute: 30)
        ]
        
        var drinkNotificationsIds: [String] = []
        for scheduleElement in dailySchedule {
            let trigger = UNCalendarNotificationTrigger(dateMatching: scheduleElement, repeats: true)
            let drinkNotificationId: String = UUID().uuidString
            let request = UNNotificationRequest(identifier: drinkNotificationId, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            drinkNotificationsIds.append(drinkNotificationId)
        }
        defaults.set(drinkNotificationsIds, forKey: Constants.drinkNotificationsIdsKey)
    }
    
    func disableDrinkNotifications() {
        var drinkNotificationsIds = defaults.value(forKey: Constants.drinkNotificationsIdsKey) as? [String] ?? []
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: drinkNotificationsIds)
        drinkNotificationsIds.removeAll()
        defaults.setValue(drinkNotificationsIds, forKey: Constants.drinkNotificationsIdsKey)
    }
    
    func enableFoodNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Dont't starve 🍎"
        content.body = "It's your reminder to eat food and be healthy!"
        content.sound = .default
        
        let dailySchedule: [DateComponents] = [
            DateComponents(hour: 9, minute: 30),
            DateComponents(hour: 13, minute: 0),
            DateComponents(hour: 18, minute: 0)
        ]
        
        var foodNotificationsIds: [String] = []
        for scheduleElement in dailySchedule {
            let trigger = UNCalendarNotificationTrigger(dateMatching: scheduleElement, repeats: true)
            let foodNotificationId: String = UUID().uuidString
            let request = UNNotificationRequest(identifier: foodNotificationId, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            foodNotificationsIds.append(foodNotificationId)
        }
        defaults.set(foodNotificationsIds, forKey: Constants.foodNotificationsIdsKey)
    }
    
    func disableFoodNotifications() {
        var foodNotificationsIds = defaults.value(forKey: Constants.foodNotificationsIdsKey) as? [String] ?? []
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: foodNotificationsIds)
        foodNotificationsIds.removeAll()
        defaults.setValue(foodNotificationsIds, forKey: Constants.foodNotificationsIdsKey)
    }
    
    func enableSleepNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Time to rest 🌙"
        content.body = "It's your sleep shedule reminder. Have a good night!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 23
        dateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let sleepNotificationId: String = UUID().uuidString
        let request = UNNotificationRequest(identifier: sleepNotificationId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        defaults.set(sleepNotificationId, forKey: Constants.sleepNotificationsIdKey)
    }
    
    func disableSleepNotifications() {
        var sleepNotificationsId = defaults.value(forKey: Constants.sleepNotificationsIdKey) as? String ?? ""
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [sleepNotificationsId])
        sleepNotificationsId = ""
        defaults.set(sleepNotificationsId, forKey: Constants.sleepNotificationsIdKey)
    }
}
