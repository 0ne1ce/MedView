//
//  HelpPresenter.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpPresenter: HelpPresentationLogic {
    // MARK: - Properties
    var view: HelpDisplayLogic?
    
    // MARK: - Functions
    func presentNavigationBar() {
        let titleLabelText = Constants.HelpView.helpLabelText
        let viewModel = NavigationBarViewModel(
            title: titleLabelText,
            isSettingsButtonHidden: false
        )
        view?.displayNavigationBar(with: viewModel)
    }
}
