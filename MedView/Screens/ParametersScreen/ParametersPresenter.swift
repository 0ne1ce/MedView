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
        static let backgroundColor: UIColor = UIColor.backgroundPrimary
        
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
        
        static let parametersFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
    }
    // MARK: - Properties
    weak var view: ParametersDisplayLogic?
    
    // MARK: - Public Fuctions
    func presentStart(response: ParametersModels.LoadStart.Response) {
        let viewModel = ParametersModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            tableBackgroundColor: Constants.backgroundColor,
            tableTitleText: response.tableTitleText,
            tableTitleColor: UIColor.parametersTitleLabel,
            tableTitleFont: Constants.parametersFont,
            navigationTitleFont: Constants.navigationTitleFont,
            settingsImage: UIImage(named: response.settingsImageName)
        )
        
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: ParametersModels.LoadSettings.Response) {
        let viewModel = ParametersModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
    
    func presentParameter(response: ParametersModels.LoadParameter.Response) {
        let viewModel = ParametersModels.LoadParameter.ViewModel()
        view?.displayParamter(viewModel: viewModel)
    }
}
