//
//  SettingsPresenter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
    }
    
    // MARK: - Properties
    var view: SettingsDisplayLogic?
    
    // MARK: - Fuctions
    func presentStart(response: SettingsModels.LoadStart.Response) {
        let viewModel = SettingsModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .black,
            navigationBackgroundColor: .white
        )
        view?.displayStart(viewModel: viewModel)
    }
}
