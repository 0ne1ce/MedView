//
//  HelpDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol HelpDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: HelpModels.LoadStart.ViewModel)
    func displaySettings(viewModel: HelpModels.LoadSettings.ViewModel)
    func displayOnboarding(viewModel: HelpModels.LoadOnboarding.ViewModel)
}
