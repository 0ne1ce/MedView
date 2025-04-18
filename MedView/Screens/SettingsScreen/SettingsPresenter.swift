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

        static let buttonTitleFont: UIFont = UIFont.systemFont(ofSize: 18)
    }
    
    // MARK: - Properties
    var view: SettingsDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: SettingsModels.LoadStart.Response) {
        let viewModel = SettingsModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary,
            buttonTitle: response.buttonTitle,
            buttonTitleFont: Constants.buttonTitleFont,
            buttonTitleColor: .white,
            buttonColor: .hse,
            buttonImageTintColor: .white,
            buttonImage: UIImage(systemName: "person.crop.circle")
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentAboutDev(response: SettingsModels.LoadAboutDev.Response) {
        let viewModel = SettingsModels.LoadAboutDev.ViewModel()
        view?.displayAboutDev(viewModel: viewModel)
    }
    
    func presentCard(response: SettingsModels.LoadCard.Response) {
        let viewModel = SettingsModels.LoadCard.ViewModel()
        view?.displayCard(viewModel: viewModel)
    }
    
    func presentNotification(response: SettingsModels.LoadNotification.Response) {
        let notification = Notification(title: response.notificationTitle)
        let viewModel = SettingsModels.LoadNotification.ViewModel(notification: notification)
        view?.displayNotification(viewModel: viewModel)
    }
}
