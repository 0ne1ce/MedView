//
//  SettingsPresenter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Properties
    var view: SettingsDisplayLogic?
    
    // MARK: - Fuctions
    func presentNavigationBar() {
        let titleLabelText = Constants.SettingsView.settingsLabelText
        let viewModel = NavigationBarViewModel(
            title: titleLabelText,
            isSettingsButtonHidden: true
        )
        view?.displayNavigationBar(with: viewModel)
    }
}
