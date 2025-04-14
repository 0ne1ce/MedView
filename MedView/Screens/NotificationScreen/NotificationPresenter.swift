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
    }
    
    // MARK: - Properties
    var view: NotificationDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: NotificationModels.LoadStart.Response) {
        let viewModel = NotificationModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary
        )
        view?.displayStart(viewModel: viewModel)
    }
}
