//
//  ParametersPresenter.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersPresenter: ParametersPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36)
        
        static let parametersTitleLabelHex: String = "999999"
        static let parametersFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
    }
    // MARK: - Properties
    weak var view: ParametersDisplayLogic?
    // MARK: - Public Fuctions
    func presentStart(response: ParametersModels.LoadStart.Response) {
        let viewModel = ParametersModels.LoadStart.ViewModel(
            titleText: response.titleText,
            tableBackgroundColor: UIColor(hex: Constants.backgroundLightHex),
            tableTitleText: response.tableTitleText,
            tableTitleColor: UIColor(hex: Constants.parametersTitleLabelHex),
            tableTitleFont: Constants.parametersFont,
            navigationTitleFont: Constants.navigationTitleFont.bold,
            settingsImage: UIImage(named: response.settingsImageName),
            navigationBackgroundColor: .white,
            borderlineColor: .lightGray
        )
        
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: ParametersModels.LoadSettings.Response) {
        let viewModel = ParametersModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
}
