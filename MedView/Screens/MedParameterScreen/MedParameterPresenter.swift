//
//  MedParameterPresenter.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import UIKit
import Foundation

final class MedParameterPresenter: MedParameterPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
        static let textFont: UIFont = .systemFont(ofSize: 20)
        
        static let placeholderText: String = "Value"
        static let placeholderFont: UIFont = UIFont.systemFont(ofSize: 18).bold
    }
    
    // MARK: - Properties
    weak var view: MedParameterDisplayLogic?
    
    // MARK: - Public functions
    func presentStart(response: MedParameterModels.LoadStart.Response) {
        let viewModel = MedParameterModels.LoadStart.ViewModel(
            backgroundColor: .backgroundPrimary,
            navigationTitle: NSMutableAttributedString("Your parameter"),
            navigationTitleFont: Constants.navigationTitleFont,
            textFont: Constants.textFont,
            inputWrapBackgroundColor: UIColor.cellBackground,
            placeholderText: Constants.placeholderText,
            placeholderFont: Constants.placeholderFont,
            placeholderColor: .lightGray,
            sendButtonColor: .main,
            sendButtonTintColor: .white
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentTextFieldValue(response: MedParameterModels.SaveValue.Response) {
        let viewModel = MedParameterModels.SaveValue.ViewModel(data: response.data)
        view?.displayTextFieldValue(viewModel: viewModel)
    }
}
