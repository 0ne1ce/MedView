//
//  SettingsBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol NotificationBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: NotificationModels.LoadStart.Request)
    func loadAddTimeScreen(request: NotificationModels.LoadAddTimeScreen.Request)
    func loadTimestamp(request: NotificationModels.AddTimestamp.Request)
    func deleteTimestamp(request: NotificationModels.DeleteTimestamp.Request)
}
