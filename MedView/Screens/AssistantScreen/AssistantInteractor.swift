//
//  AssistantInteractor.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantInteractor: AssistantBuisnessLogic {
    // MARK: - Constants
    enum Constants {
        static let assistantLabelText: String = "MV Assistant"
        static let settingsImageName: String = "SettingsSymbol"
    }
    // MARK: - Properties
    var presenter: AssistantPresentationLogic
    var worker: AssistantWorker
    
    // MARK: - Initialization
    init(presenter: AssistantPresentationLogic, worker: AssistantWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Functions
    func loadStart(request: AssistantModels.LoadStart.Request) {
        let response = AssistantModels.LoadStart.Response(titleText: Constants.assistantLabelText, settingsImageName: Constants.settingsImageName)
        presenter.presentStart(response: response)
    }
    
    func loadSettings(request: AssistantModels.LoadSettings.Request) {
        let response = AssistantModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
}
