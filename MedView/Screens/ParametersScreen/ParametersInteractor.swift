//
//  ParametersInteractor.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersInteractor: ParametersBuisnessLogic {
    // MARK: - Properties
    var presenter: ParametersPresentationLogic
    var worker: ParametersWorker
    
    // MARK: - Initialization
    init(presenter: ParametersPresentationLogic, worker: ParametersWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func fetchNavigationBar(request: ParametersModels.FetchNavigationBar.Request) {
        let response = ParametersModels.FetchNavigationBar.Response(titleText: configuredTitle())
        presenter.presentNavigationBar(response: response)
    }
    
    func fetchParameters(request: ParametersModels.FetchParameters.Request) {
        let response = ParametersModels.FetchParameters.Response(tableTitleText: "Your health parameters")
        presenter.presentParameters(response: response)
    }
    
    // MARK: - Private functions
    private func configuredTitle() -> NSMutableAttributedString {
        let titleLabelText = ParametersConstants.medViewLabelText
        let attributedTitleText = NSMutableAttributedString(string: titleLabelText)
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: UIColor.black,
                range: NSRange(
                    location: ParametersConstants.systemColorStringLocation,
                    length: ParametersConstants.systemColorStringLength
                )
            )
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: UIColor.systemMint,
                range: NSRange(
                    location: ParametersConstants.mintColorStringLocation,
                    length: ParametersConstants.mintColorStringLength
                )
            )
        return attributedTitleText
    }
}
