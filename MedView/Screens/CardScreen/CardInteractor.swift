//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class CardInteractor: CardBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let cardLabelText: NSMutableAttributedString = NSMutableAttributedString("Your card")
    }
    
    // MARK: - Properties
    var presenter: CardPresentationLogic
    var worker: CardWorker
    
    // MARK: - Initialization
    init(presenter: CardPresentationLogic, worker: CardWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: CardModels.LoadStart.Request) {
        let response = CardModels.LoadStart.Response(
            titleText: Constants.cardLabelText
        )
        presenter.presentStart(response: response)
    }
}
