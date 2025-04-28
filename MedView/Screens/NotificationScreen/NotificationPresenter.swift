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
            type: response.type,
            tableTitleText: response.tableTitleText,
            tableTitleColor: UIColor.parametersTitleLabel,
            tableTitleFont: Constants.tableTitleFont,
            tableBackgroundColor: Constants.backgroundColor
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentAddTimeScreen(response: NotificationModels.LoadAddTimeScreen.Response) {
        if let timestamp = response.timestamp {
            let convertedTimestamp = Timestamp(
                time: timestamp.timestampValue,
                repeatStatus: timestamp.repeatStatusEnabled
            )
            let viewModel = NotificationModels.LoadAddTimeScreen.ViewModel(timestamp: convertedTimestamp)
            view?.displayAddTimeScreen(viewModel: viewModel)
        } else {
            let viewModel = NotificationModels.LoadAddTimeScreen.ViewModel()
            view?.displayAddTimeScreen(viewModel: viewModel)
        }
    }
    
    func presentTimestamp(response: NotificationModels.AddTimestamp.Response) {
        let viewModel = NotificationModels.AddTimestamp.ViewModel()
        view?.displayTimestamp(viewModel: viewModel)
    }
    
    func presentTimestampsAfterDeletion(response: NotificationModels.DeleteTimestamp.Response) {
        let viewModel = NotificationModels.DeleteTimestamp.ViewModel(index: response.index)
        view?.displayTimestampsAfterDeletion(viewModel: viewModel)
    }
}
