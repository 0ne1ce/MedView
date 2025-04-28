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
    var timeStamps: [TimestampData] = []
    
    // MARK: - Initialization
    init(presenter: NotificationPresentationLogic, worker: NotificationWorker, notification: Notification) {
        self.presenter = presenter
        self.worker = worker
        self.notification = notification
    }
    
    // MARK: - Public functions
    func loadStart(request: NotificationModels.LoadStart.Request) {
        loadNotificationTimestampsData()
        timeStamps.sort { $0.timestampValue < $1.timestampValue }
        let response = NotificationModels.LoadStart.Response(
            titleText: NSMutableAttributedString(string: notification.title),
            type: notification.type,
            tableTitleText: Constants.tableTitleText
        )
        presenter.presentStart(response: response)
    }
    
    func loadAddTimeScreen(request: NotificationModels.LoadAddTimeScreen.Request) {
        if let index = request.index {
            let response = NotificationModels.LoadAddTimeScreen.Response(timestamp: timeStamps[index])
            presenter.presentAddTimeScreen(response: response)
        } else {
            let response = NotificationModels.LoadAddTimeScreen.Response()
            presenter.presentAddTimeScreen(response: response)
        }
    }
    
    func loadTimestamp(request: NotificationModels.AddTimestamp.Request) {
        if timeStamps.contains(where: { $0.timestampValue == request.timestamp.time &&
            $0.repeatStatusEnabled == request.timestamp.repeatStatus
        }) {
            return
        } else if let index = timeStamps.firstIndex(where: { $0.timestampValue == request.timestamp.time &&
            $0.repeatStatusEnabled != request.timestamp.repeatStatus }) {
            timeStamps[index].repeatStatusEnabled = request.timestamp.repeatStatus
        }
        deleteNotificationTimestampsData(
            timestamp: request.timestamp.time,
            repeatStatus: request.timestamp.repeatStatus
        )
        saveNotificationTimestampsData(
            timestamp: request.timestamp.time,
            repeatStatus: request.timestamp.repeatStatus
        )
        loadNotificationTimestampsData()
        timeStamps.sort { $0.timestampValue < $1.timestampValue }
        
        if notification.type == .custom {
            syncCustomNotifications()
        } else {
            syncNotifications()
        }
        let response = NotificationModels.AddTimestamp.Response()
        presenter.presentTimestamp(response: response)
    }
    
    func deleteTimestamp(request: NotificationModels.DeleteTimestamp.Request) {
        let timestampForDeletion = timeStamps[request.index]
        timeStamps.remove(at: request.index)
        deleteNotificationTimestampsData(
            timestamp: timestampForDeletion.timestampValue,
            repeatStatus: timestampForDeletion.repeatStatusEnabled
        )
        loadNotificationTimestampsData()
        
        if notification.type == .custom {
            syncCustomNotifications()
        } else {
            syncNotifications()
        }
        let response = NotificationModels.DeleteTimestamp.Response(index: request.index)
        presenter.presentTimestampsAfterDeletion(response: response)
    }
    
    func syncNotifications() {
        let settingsWorker = SettingsWorker()
        let states = settingsWorker.loadDefaultNotificationsStates()
        
        switch notification.id {
        case 0:
            if states[0] {
                settingsWorker.enableNotifications(notificationType: .drink)
            }
        case 1:
            if states[1] {
                settingsWorker.enableNotifications(notificationType: .food)
            }
        case 2:
            if states[2] {
                settingsWorker.enableNotifications(notificationType: .sleep)
            }
        default:
            break
        }
    }
    
    func syncCustomNotifications() {
        let settingsWorker = SettingsWorker()
        let states = settingsWorker.loadDefaultNotificationsStates()
        let titles = settingsWorker.loadCustomNotifications()
        let index = titles.firstIndex(of: notification.title) ?? 0
        if !states.isEmpty && states[index] {
            settingsWorker.enableNotifications(notificationType: .custom, customTitle: notification.title)
        }
    }
    
    // MARK: - Private functions
    private func loadNotificationTimestampsData() {
        switch notification.id {
        case 0:
            loadNotificationTimestampsData(type: DrinkTimestamp.self)
        case 1:
            loadNotificationTimestampsData(type: FoodTimestamp.self)
        case 2:
            loadNotificationTimestampsData(type: SleepTimestamp.self)
        default:
            loadNotificationTimestampsData(type: CustomTimestamp.self)
        }
    }
    
    private func loadNotificationTimestampsData<T: TimestampData>(type: T.Type) {
        timeStamps = worker.loadTimestampsData(type: type)
    }
    
    private func saveNotificationTimestampsData(timestamp: String, repeatStatus: Bool) {
        switch notification.id {
        case 0:
            saveNotificationTimestampsData(type: DrinkTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        case 1:
            saveNotificationTimestampsData(type: FoodTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        case 2:
            saveNotificationTimestampsData(type: SleepTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        default:
            saveNotificationTimestampsData(type: CustomTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        }
    }
    
    private func saveNotificationTimestampsData<T: TimestampData>(type: T.Type, timestamp: String, repeatStatus: Bool) {
        worker.saveTimestampsData(type: type, time: timestamp, repeatStatus: repeatStatus)
    }
    
    private func deleteNotificationTimestampsData(timestamp: String, repeatStatus: Bool) {
        switch notification.id {
        case 0:
            deleteNotificationTimestampsData(type: DrinkTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        case 1:
            deleteNotificationTimestampsData(type: FoodTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        case 2:
            deleteNotificationTimestampsData(type: SleepTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        default:
            deleteNotificationTimestampsData(type: CustomTimestamp.self, timestamp: timestamp, repeatStatus: repeatStatus)
        }
    }
    
    private func deleteNotificationTimestampsData<T: TimestampData>(type: T.Type, timestamp: String, repeatStatus: Bool) {
        worker.deleteTimestampsData(type: type, time: timestamp, repeatStatus: repeatStatus)
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
        
        let convertedTimestamp = Timestamp(
            time: timestamp.timestampValue,
            repeatStatus: timestamp.repeatStatusEnabled
        )
        
        timestampCell.configure(timestamp: convertedTimestamp)
            
        return timestampCell
    }
}
