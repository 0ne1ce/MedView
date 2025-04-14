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

    }
    
    // MARK: - Properties
    weak var view: MedParameterDisplayLogic?
    
    // MARK: - Public functions
    func presentStart(response: MedParameterModels.LoadStart.Response) {
        let viewModel = MedParameterModels.LoadStart.ViewModel(backgroundColor: .backgroundPrimary)
        view?.displayStart(viewModel: viewModel)
    }
}
