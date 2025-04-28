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
        
        let notification = Notification(
            id: response.id,
            title: response.notificationTitle,
            type: response.notificationType
        )
        let viewModel = SettingsModels.LoadNotification.ViewModel(notification: notification)
        view?.displayNotification(viewModel: viewModel)
    }
    
    func presentCustomNotification(response: SettingsModels.AddCustomNotification.Response) {
        let viewModel = SettingsModels.AddCustomNotification.ViewModel()
        view?.displayCustomNotification(viewModel: viewModel)
    }
    
    func presentNotificationsAfterDeletion(response: SettingsModels.DeleteCustomNotification.Response) {
        let viewModel = SettingsModels.DeleteCustomNotification.ViewModel(index: response.index)
        view?.displayNotificationsAfterDeletion(viewModel: viewModel)
    }
    
    func presentSyncNotifications(response: SettingsModels.SyncNotifications.Response) {
        let viewModel = SettingsModels.SyncNotifications.ViewModel()
        view?.displaySyncNotifications(viewModel: viewModel)
    }
    
    func presentSyncCustomNotifications(response: SettingsModels.SyncCustomNotifications.Response) {
        let viewModel = SettingsModels.SyncCustomNotifications.ViewModel()
        view?.displaySyncCustomNotifications(viewModel: viewModel)
    }
}
