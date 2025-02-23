//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsInteractor: SettingsBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let settingsLabelText: NSMutableAttributedString = NSMutableAttributedString("Settings")
    }
    
    // MARK: - Properties
    var presenter: SettingsPresentationLogic
    var worker: SettingsWorker
    
    // MARK: - Initialization
    init(presenter: SettingsPresentationLogic, worker: SettingsWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: SettingsModels.LoadStart.Request) {
        let response = SettingsModels.LoadStart.Response(titleText: Constants.settingsLabelText)
        presenter.presentStart(response: response)
    }
}
