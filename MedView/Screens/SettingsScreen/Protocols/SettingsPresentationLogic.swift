//
//  SettingsPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol SettingsPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: SettingsModels.LoadStart.Response)
    func presentAboutDev(response: SettingsModels.LoadAboutDev.Response)
    func presentCard(response: SettingsModels.LoadCard.Response)
    func presentNotification(response: SettingsModels.LoadNotification.Response)
    func presentCustomNotification(response: SettingsModels.AddCustomNotification.Response)
    func presentNotificationsAfterDeletion(response: SettingsModels.DeleteCustomNotification.Response)
}
