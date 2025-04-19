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
    var timeStamps: [Timestamp] = [
        Timestamp(time: "9:00", repeatStatus: false),
        Timestamp(time: "11:30", repeatStatus: false),
        Timestamp(time: "14:00", repeatStatus: false),
        Timestamp(time: "16:30", repeatStatus: false),
        Timestamp(time: "19:00", repeatStatus: false),
        Timestamp(time: "21:30", repeatStatus: false)
        
    ]
    
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
        return timeStamps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimestampCell.reuseId, for: indexPath)
        let timestamp = timeStamps[indexPath.row]
        guard let timestampCell = cell as? TimestampCell else {
            return cell
        }
        
        timestampCell.configure(timestamp: timestamp)
            
        return timestampCell
    }
}
