//
//  HelpPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol HelpPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: HelpModels.LoadStart.Response)
    func presentSettings(response: HelpModels.LoadSettings.Response)
}
