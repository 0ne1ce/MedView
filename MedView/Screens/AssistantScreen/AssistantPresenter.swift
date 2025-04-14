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
        
        static let placeholderFont: UIFont = UIFont.systemFont(ofSize: 18).bold
    }
    // MARK: - Properties
    var view: AssistantDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: AssistantModels.LoadStart.Response) {
        let viewModel = AssistantModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            settingsImage: UIImage(named: response.settingsImageName),
            placeholderText: response.placeholderText,
            placeholderFont: Constants.placeholderFont,
            placeholderColor: .lightGray,
            inputWrapBackgroundColor: UIColor.cellBackground,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary,
            sendButtonColor: .main,
            sendButtonTintColor: .white,
            tableBackgroundColor: .clear,
            animationName: response.animationName
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: AssistantModels.LoadSettings.Response) {
        let viewModel = AssistantModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
    
    func presentUserMessage(response: AssistantModels.SendUserMessage.Response) {
        let viewModel = AssistantModels.SendUserMessage.ViewModel(
            placeholderText: response.placeholderText,
            placeholderColor: .lightGray
        )
        view?.displayMessage(viewModel: viewModel)
    }
    
    func presentAssistantMessage(response: AssistantModels.SendAssistantMessage.Response) {
        let viewModel = AssistantModels.SendAssistantMessage.ViewModel()
        view?.displayAssistantMessage(viewModel: viewModel)
    }
    
}
