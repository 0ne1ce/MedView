//
//  AssistantPresenter.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantPresenter: AssistantPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
    }
    // MARK: - Properties
    var view: AssistantDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: AssistantModels.LoadStart.Response) {
        let viewModel = AssistantModels.LoadStart.ViewModel(
            titleText: response.titleText,
            settingsImage: UIImage(named: response.settingsImageName),
            navigationTitleFont: Constants.navigationTitleFont,
            navigationBackgroundColor: .white,
            borderlineColor: .lightGray
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: AssistantModels.LoadSettings.Response) {
        let viewModel = AssistantModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
}
