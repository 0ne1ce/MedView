//
//  AssistantDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol AssistantDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: AssistantModels.LoadStart.ViewModel)
    func displaySettings(viewModel: AssistantModels.LoadSettings.ViewModel)
    func displayMessage(viewModel: AssistantModels.SendUserMessage.ViewModel)
    func displayAssistantMessage(viewModel: AssistantModels.SendAssistantMessage.ViewModel)
}
