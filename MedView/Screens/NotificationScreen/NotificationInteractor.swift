//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class NotificationInteractor: NSObject, NotificationBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let tableTitleText: String = "Notification timestamps"
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
            titleText: NSMutableAttributedString(string: notification.title),
            customType: notification.customType,
            tableTitleText: Constants.tableTitleText
        )
        presenter.presentStart(response: response)
    }
    
    func loadAddTimeScreen(request: NotificationModels.LoadAddTimeScreen.Request) {
        let response = NotificationModels.LoadAddTimeScreen.Response()
        presenter.presentAddTimeScreen(response: response)
    }
}

// MARK: - UITableViewDataSource
extension NotificationInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimestampCell.reuseId, for: indexPath)
        guard let timestampCell = cell as? TimestampCell else {
            return cell
        }
        
        timestampCell.configure(time: "7:00", status: "On")
            
        return timestampCell
    }
}
