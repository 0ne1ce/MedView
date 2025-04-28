//
//  SettingsWorker.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit
import CoreData

final class SettingsWorker {
    // MARK: - Constants
    private enum Constants {
        static let isSettingsInitialized: String = "isSettingsInitialized"
        static let customNotificationsKey: String = "customNotifications"
        static let defaultNotificatonsSwitchStatesKey: String = "defaultNotificationsStates"
        static let drinkNotificationsIdsKey: String = "drinkNotificationsIds"
        static let foodNotificationsIdsKey: String = "foodNotificationsIds"
        static let sleepNotificationsIdsKey: String = "sleepNotificationsIds"
        static let customNotificationsIdsKey: String = "customNotificationsIds"
        
        static let customNotificatonsSwitchStatesKey: String = "customNotificationsStates"
        
        static let timeComponentsCount: Int = 2
        static let repeatAfterMinutes: Int = 5
        static let misutesPerHour: Int = 60
        static let extraHour: Int = 1
        static let minutesBound: Int = 59
    }
    
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    private let notificationWorker = NotificationWorker()
    private let context = CoreDataStack.shared.context
    
    // MARK: - Initialization
    init() {
        guard !defaults.bool(forKey: Constants.isSettingsInitialized) else {
            return
        }
        if !defaults.bool(forKey: Constants.isSettingsInitialized) {
            defaults.set([false, false, false], forKey: Constants.defaultNotificatonsSwitchStatesKey)
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
    
    func enableNotifications(notificationType: NotificationType, customTitle: String? = nil) {
        disableNotifications(notificationType: notificationType)
        let content = UNMutableNotificationContent()
        content.sound = .default
        var timestamps: [TimestampData]
        
        switch notificationType {
        case .drink:
            content.title = "Stay hydrated 🥤"
            content.body = "It's your reminder to drink water and be healthy!"
            timestamps = notificationWorker.loadTimestampsData(type: DrinkTimestamp.self)
        case .food:
            content.title = "Dont't starve 🍎"
            content.body = "It's your reminder to eat food and be healthy!"
            timestamps = notificationWorker.loadTimestampsData(type: FoodTimestamp.self)
        case .sleep:
            content.title = "Time to rest 🌙"
            content.body = "It's your sleep shedule reminder. Have a good night!"
            timestamps = notificationWorker.loadTimestampsData(type: SleepTimestamp.self)
        case .custom:
            content.title = customTitle ?? "Custom notification"
            content.body = "It's your custom notification reminder. Stay healthy!"
            timestamps = notificationWorker.loadTimestampsData(type: CustomTimestamp.self)
        }
        
        var notificationsIds: [String] = []
        
        for timestamp in timestamps {
            let timeComponents = parseTimeString(timestamp.timestampValue)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: timeComponents, 
                repeats: true
            )
            
            let notificationId = UUID().uuidString
            let request = UNNotificationRequest(
                identifier: notificationId, 
                content: content, 
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
            notificationsIds.append(notificationId)
            
            if timestamp.repeatStatusEnabled {
                let newContent = UNMutableNotificationContent()
                newContent.title = "Repeat: " + content.title
                newContent.body = content.body
                newContent.sound = .default
                
                var reminderComponents = timeComponents
                reminderComponents.minute = (reminderComponents.minute ?? .zero) + Constants.repeatAfterMinutes
                
                if let minutes = reminderComponents.minute, minutes > Constants.minutesBound {
                    reminderComponents.minute = minutes - Constants.misutesPerHour
                    reminderComponents.hour = (reminderComponents.hour ?? .zero) + Constants.extraHour
                }
                
                let reminderTrigger = UNCalendarNotificationTrigger(
                    dateMatching: reminderComponents, 
                    repeats: timestamp.repeatStatusEnabled
                )
                
                let reminderNotificationId = UUID().uuidString
                let reminderRequest = UNNotificationRequest(
                    identifier: reminderNotificationId, 
                    content: newContent, 
                    trigger: reminderTrigger
                )
                
                UNUserNotificationCenter.current().add(reminderRequest)
                notificationsIds.append(reminderNotificationId)
            }
        }
        
        switch notificationType {
        case .drink:
            defaults.set(notificationsIds, forKey: Constants.drinkNotificationsIdsKey)
        case .food:
            defaults.set(notificationsIds, forKey: Constants.foodNotificationsIdsKey)
        case .sleep:
            defaults.set(notificationsIds, forKey: Constants.sleepNotificationsIdsKey)
        case .custom:
            defaults.set(notificationsIds, forKey: Constants.customNotificationsIdsKey)
        }
    }
    
    func disableNotifications(notificationType: NotificationType) {
        switch notificationType {
        case .drink:
            var drinkNotificationsIds = defaults.value(forKey: Constants.drinkNotificationsIdsKey) as? [String] ?? []
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: drinkNotificationsIds)
            drinkNotificationsIds.removeAll()
            defaults.setValue(drinkNotificationsIds, forKey: Constants.drinkNotificationsIdsKey)
        case .food:
            var foodNotificationsIds = defaults.value(forKey: Constants.foodNotificationsIdsKey) as? [String] ?? []
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: foodNotificationsIds)
            foodNotificationsIds.removeAll()
            defaults.setValue(foodNotificationsIds, forKey: Constants.foodNotificationsIdsKey)
        case .sleep:
            var sleepNotificationsIds = defaults.value(forKey: Constants.sleepNotificationsIdsKey) as? [String] ?? []
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: sleepNotificationsIds)
            sleepNotificationsIds.removeAll()
            defaults.setValue(sleepNotificationsIds, forKey: Constants.sleepNotificationsIdsKey)
        case .custom:
            var customNotificationsIds = defaults.value(forKey: Constants.customNotificationsIdsKey) as? [String] ?? []
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: customNotificationsIds)
            customNotificationsIds.removeAll()
            defaults.setValue(customNotificationsIds, forKey: Constants.customNotificationsIdsKey)
        }
    }
    
    func createCustomNotification(notificationId: Int) {
        if loadCustomNotification(id: notificationId) != nil {
            print("Notification with id \(notificationId) already exists.")
            return
        }
        
        let newNotification = CustomNotification(context: context)
        newNotification.id = Int64(notificationId)
        CoreDataStack.shared.saveContext()
        
        print("Created notification with id \(notificationId)")
    }

    func loadCustomNotification(id: Int) -> CustomNotification? {
        let request: NSFetchRequest<CustomNotification> = CustomNotification.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", id as CVarArg)
        return try? context.fetch(request).first
    }
    
    func deleteCustomNotification(id: Int) {
        guard let notification = loadCustomNotification(id: id) else { return }
        
        if let timestamps = notification.timestamps as? Set<CustomTimestamp> {
            for timestamp in timestamps {
                context.delete(timestamp)
            }
        }
        
        context.delete(notification)
        CoreDataStack.shared.saveContext()
    }
    
    // MARK: - Private functions
    private func parseTimeString(_ timeString: String) -> DateComponents {
        let components = timeString.components(separatedBy: ":")
        guard components.count == Constants.timeComponentsCount,
              let hour = Int(components[0]),
              let minute = Int(components[1]) else {
            return DateComponents(hour: .zero, minute: .zero)
        }
        return DateComponents(hour: hour, minute: minute)
    }
}
