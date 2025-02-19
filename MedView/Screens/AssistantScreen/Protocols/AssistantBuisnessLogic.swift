//
//  AssistantBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol AssistantBuisnessLogic: AnyObject {
    // MARK: - Functions
    func loadStart(request: AssistantModels.LoadStart.Request)
    func loadSettings(request: AssistantModels.LoadSettings.Request)
}
