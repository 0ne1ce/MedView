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
        static let backgroundLightHex: String = "F2F2F7"
    }
    
    // MARK: - Properties
    weak var view: MedParameterDisplayLogic?
    
    // MARK: - Public functions
    func presentStart(response: MedParameterModels.LoadStart.Response) {
        let viewModel = MedParameterModels.LoadStart.ViewModel(backgroundColorHex: Constants.backgroundLightHex)
        view?.displayStart(viewModel: viewModel)
    }
}
