//
//  SettingsDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol CardDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: CardModels.LoadStart.ViewModel)
    func displayTextFieldValue(viewModel: CardModels.SaveValue.ViewModel)
}
