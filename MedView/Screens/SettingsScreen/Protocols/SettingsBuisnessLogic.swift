//
//  SettingsBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol SettingsBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: SettingsModels.LoadStart.Request)
    func loadAboutDev(request: SettingsModels.LoadAboutDev.Request)
    func loadCard(request: SettingsModels.LoadCard.Request)
    func loadNotification(request: SettingsModels.LoadNotification.Request)
    func addCustomNotification(request: SettingsModels.AddCustomNotification.Request)
    func deleteCustomNotification(request: SettingsModels.DeleteCustomNotification.Request)
    func syncNotifications(request: SettingsModels.SyncNotifications.Request)
    func syncCustomNotifications(request: SettingsModels.SyncCustomNotifications.Request)
}
