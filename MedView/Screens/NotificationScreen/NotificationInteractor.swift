//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class NotificationInteractor: NotificationBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let cardLabelText: NSMutableAttributedString = NSMutableAttributedString("Notification")
    }
    
    // MARK: - Properties
    var presenter: NotificationPresentationLogic
    var worker: NotificationWorker
    
    // MARK: - Initialization
    init(presenter: NotificationPresentationLogic, worker: NotificationWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: NotificationModels.LoadStart.Request) {
        let response = NotificationModels.LoadStart.Response(
            titleText: Constants.cardLabelText
        )
        presenter.presentStart(response: response)
    }
}
