//
//  HelpBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol HelpBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: HelpModels.LoadStart.Request)
    func loadSettings(request: HelpModels.LoadSettings.Request)
}
