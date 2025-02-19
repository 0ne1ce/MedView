//
//  ParametersInteractorInput.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

protocol ParametersBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStartData(request: ParametersModels.LoadStart.Request)
    func loadSettings(request: ParametersModels.LoadSettings.Request)
}
