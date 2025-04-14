//
//  SettingsPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol NotificationPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: NotificationModels.LoadStart.Response)
}
