//
//  SettingsDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol NotificationDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: NotificationModels.LoadStart.ViewModel)
    func displayAddTimeScreen(viewModel: NotificationModels.LoadAddTimeScreen.ViewModel)
}
