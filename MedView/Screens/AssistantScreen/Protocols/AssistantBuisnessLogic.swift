//
//  AssistantBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

protocol AssistantBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: AssistantModels.LoadStart.Request)
    func loadSettings(request: AssistantModels.LoadSettings.Request)
    func sendMessage(request: AssistantModels.SendUserMessage.Request)
    func sendAssistantMessage(request: AssistantModels.SendAssistantMessage.Request) async
}
