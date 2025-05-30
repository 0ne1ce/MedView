//
//  SettingsPresenter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class CardPresenter: CardPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
    }
    
    // MARK: - Properties
    var view: CardDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: CardModels.LoadStart.Response) {
        let viewModel = CardModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentTextFieldValue(response: CardModels.SaveValue.Response) {
        let viewModel = CardModels.SaveValue.ViewModel()
        view?.displayTextFieldValue(viewModel: viewModel)
    }
}
