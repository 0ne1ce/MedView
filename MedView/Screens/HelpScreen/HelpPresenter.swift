//
//  HelpPresenter.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpPresenter: HelpPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
        
        static let onboardingButtonTextFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
    
    // MARK: - Properties
    var view: HelpDisplayLogic?
    
    // MARK: - Functions
    func presentStart(response: HelpModels.LoadStart.Response) {
        let viewModel = HelpModels.LoadStart.ViewModel(
            navigationTitle: response.titleText,
            settingsImage: UIImage(named: response.settingsImageName),
            navigationTitleFont: Constants.navigationTitleFont,
            navigationTitleColor: .textPrimary,
            animationName: response.animationName,
            tableBackgroundColor: .clear,
            onboardingButtonColor: .cellBackground,
            onboardingButtonBoundsColor: .textPrimary,
            onboardingButtonText: response.onboardingButtonText,
            onboardingButtonTextColor: .textPrimary,
            onboardingButtonTextFont: Constants.onboardingButtonTextFont
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: HelpModels.LoadSettings.Response) {
        let viewModel = HelpModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
    
    func presentOnboarding(response: HelpModels.LoadOnboarding.Response) {
        let viewModel = HelpModels.LoadOnboarding.ViewModel()
        view?.displayOnboarding(viewModel: viewModel)
    }
}
