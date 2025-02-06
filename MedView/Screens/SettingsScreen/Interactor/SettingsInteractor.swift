//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsInteractor: SettingsBuisnessLogic, SettingsDataStore {
    // MARK: - Properties
    var presenter: SettingsPresentationLogic?
    var worker: SettingsWorker?
    
    // MARK: - Public functions
    func configureNavigationBar() {
        presenter?.presentNavigationBar()
    }
}
