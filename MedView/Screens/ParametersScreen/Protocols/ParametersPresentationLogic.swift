//
//  ParametersPresenterInput.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

protocol ParametersPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: ParametersModels.LoadStart.Response)
    func presentSettings(response: ParametersModels.LoadSettings.Response)
    func presentParameter(response: ParametersModels.LoadParameter.Response)
    func presentOnboarding(response: ParametersModels.FirstLaunch.Response)
}
