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
}
