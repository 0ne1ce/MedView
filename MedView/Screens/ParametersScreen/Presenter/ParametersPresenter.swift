//
//  ParametersPresenter.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersPresenter: ParametersPresentationLogic {
    // MARK: - Properties
    var view: ParametersDisplayLogic?
    
    // MARK: - Fuctions
    func presentNavigationBar() {
        let titleLabelText = Constants.ParametersView.medViewLabelText
        let attributedMedViewText = NSMutableAttributedString(string: titleLabelText)
        attributedMedViewText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: Constants.ParametersView.systemColorStringLocation, length: Constants.ParametersView.systemColorStringLength))
        attributedMedViewText.addAttribute(.foregroundColor, value: UIColor.systemMint, range: NSRange(location: Constants.ParametersView.mintColorStringLocation, length: Constants.ParametersView.mintColorStringLength))
        let viewModel = NavigationBarViewModel(
            attributedTitle: attributedMedViewText,
            isSettingsButtonHidden: false
        )
        view?.displayNavigationBar(with: viewModel)
    }
}
