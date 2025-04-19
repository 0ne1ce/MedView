//
//  AbourDevPresenter.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation

final class AddTimePresenter: AddTimePresentationLogic {
    // MARK: - Constants
    private enum Constants {
    }
    
    // MARK: - Properties
    weak var view: AddTimeDisplayLogic?
    
    func presentStart(response: AddTimeModels.LoadStart.Response) {
        let viewModel = AddTimeModels.LoadStart.ViewModel(backgroundColor: .backgroundPrimary)
        view?.displayStart(viewModel: viewModel)
    }
    
}
