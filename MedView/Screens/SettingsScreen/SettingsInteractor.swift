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
        
        static let aboutDevButtonTitle: String = "About dev"
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
        let response = SettingsModels.LoadStart.Response(
            titleText: Constants.settingsLabelText,
            buttonTitle: Constants.aboutDevButtonTitle
        )
        presenter.presentStart(response: response)
    }
    
    func loadAboutDev(request: SettingsModels.LoadAboutDev.Request) {
        let response = SettingsModels.LoadAboutDev.Response()
        presenter.presentAboutDev(response: response)
    }
}
