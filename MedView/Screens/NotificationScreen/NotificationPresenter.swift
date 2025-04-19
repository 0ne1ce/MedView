//
//  SettingsPresenter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class NotificationPresenter: NotificationPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
        
        static let tableTitleFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
        
        static let backgroundColor: UIColor = UIColor.backgroundPrimary
    }
    
    // MARK: - Properties
    var view: NotificationDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: NotificationModels.LoadStart.Response) {
        let viewModel = NotificationModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary,
            customType: response.customType,
            tableTitleText: response.tableTitleText,
            tableTitleColor: UIColor.parametersTitleLabel,
            tableTitleFont: Constants.tableTitleFont,
            tableBackgroundColor: Constants.backgroundColor
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentAddTimeScreen(response: NotificationModels.LoadAddTimeScreen.Response) {
        let viewModel = NotificationModels.LoadAddTimeScreen.ViewModel()
        view?.displayAddTimeScreen(viewModel: viewModel)
    }
}
