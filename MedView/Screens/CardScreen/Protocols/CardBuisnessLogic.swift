//
//  SettingsBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol CardBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: CardModels.LoadStart.Request)
    func saveTextFieldValue(request: CardModels.SaveValue.Request)
}
