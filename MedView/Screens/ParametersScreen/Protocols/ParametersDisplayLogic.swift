//
//  ParametersDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

protocol ParametersDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: ParametersModels.LoadStart.ViewModel)
    func displaySettings(viewModel: ParametersModels.LoadSettings.ViewModel)
}
