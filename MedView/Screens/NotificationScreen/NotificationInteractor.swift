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

    }
    
    // MARK: - Properties
    var presenter: NotificationPresentationLogic
    var worker: NotificationWorker
    var notification: Notification
    
    // MARK: - Initialization
    init(presenter: NotificationPresentationLogic, worker: NotificationWorker, notification: Notification) {
        self.presenter = presenter
        self.worker = worker
        self.notification = notification
    }
    
    // MARK: - Public functions
    func loadStart(request: NotificationModels.LoadStart.Request) {
        let response = NotificationModels.LoadStart.Response(
            titleText: NSMutableAttributedString(string: notification.title)
        )
        presenter.presentStart(response: response)
    }
}
