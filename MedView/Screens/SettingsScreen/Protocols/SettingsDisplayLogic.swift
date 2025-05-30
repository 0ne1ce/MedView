//
//  SettingsDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol SettingsDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: SettingsModels.LoadStart.ViewModel)
    func displayAboutDev(viewModel: SettingsModels.LoadAboutDev.ViewModel)
    func displayCard(viewModel: SettingsModels.LoadCard.ViewModel)
    func displayNotification(viewModel: SettingsModels.LoadNotification.ViewModel)
    func displayCustomNotification(viewModel: SettingsModels.AddCustomNotification.ViewModel)
    func displayNotificationsAfterDeletion(viewModel: SettingsModels.DeleteCustomNotification.ViewModel)
    func displaySyncNotifications(viewModel: SettingsModels.SyncNotifications.ViewModel)
    func displaySyncCustomNotifications(viewModel: SettingsModels.SyncCustomNotifications.ViewModel)
}
