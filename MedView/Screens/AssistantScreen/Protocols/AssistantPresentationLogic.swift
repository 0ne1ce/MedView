//
//  AssistantPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol AssistantPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: AssistantModels.LoadStart.Response)
    func presentSettings(response: AssistantModels.LoadSettings.Response)
    func presentUserMessage(response: AssistantModels.SendUserMessage.Response)
    func presentAssistantMessage(response: AssistantModels.SendAssistantMessage.Response)
}
