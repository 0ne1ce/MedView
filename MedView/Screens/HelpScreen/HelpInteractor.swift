//
//  HelpInteractor.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpInteractor: HelpBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let helpLabelText: NSMutableAttributedString = NSMutableAttributedString("FAQ and guide")
        static let settingsImageName: String = "SettingsSymbol"
    }
    
    // MARK: - Properties
    var presenter: HelpPresentationLogic
    var worker: HelpWorker
    
    // MARK: - Initialization
    init(presenter: HelpPresentationLogic, worker: HelpWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Functions
    func loadStart(request: HelpModels.LoadStart.Request) {
        let response = HelpModels.LoadStart.Response(
            titleText: Constants.helpLabelText,
            settingsImageName: Constants.settingsImageName
        )
        presenter.presentStart(response: response)
    }
    
    func loadSettings(request: HelpModels.LoadSettings.Request) {
        let response = HelpModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
    
}
