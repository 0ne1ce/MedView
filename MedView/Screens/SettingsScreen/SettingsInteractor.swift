//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit
import UserNotifications

final class SettingsInteractor: NSObject, SettingsBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let settingsLabelText: NSMutableAttributedString = NSMutableAttributedString("Settings")
        
        static let aboutDevButtonTitle: String = "About dev"
        
        static let numberOfSections: Int = 4
        static let numberOfRowsCard: Int = 1
        static let numberOfRowsTheme: Int = 1
        static let numberOfRowsNotificationsDefault: Int = 3
        static let numberOfRowsNotificationsCreation: Int = 1
        static let notificationsDefaultTitles: [String] = [
            "Stay hydrated",
            "Eat food",
            "Sleep schedule"
        ]
    }
    
    // MARK: - Properties
    var presenter: SettingsPresentationLogic
    var worker: SettingsWorker
    
    var themeState: Bool = false
    var notificationsCustomTitles: [String] = []
    
    var notificationsDefaultStates: [Bool] = []
    var notificationsCustomStates: [Bool] = []
    
    // MARK: - Initialization
    init(presenter: SettingsPresentationLogic, worker: SettingsWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: SettingsModels.LoadStart.Request) {
        notificationsCustomTitles = worker.loadCustomNotifications()
        notificationsDefaultStates = worker.loadDefaultNotificationsStates()
        notificationsCustomStates = worker.loadCustomNotificationsStates()
        let response = SettingsModels.LoadStart.Response(
            titleText: Constants.settingsLabelText,
            buttonTitle: Constants.aboutDevButtonTitle
        )
        presenter.presentStart(response: response)
    }
    
    func loadAboutDev(request: SettingsModels.LoadAboutDev.Request) {
        let response = SettingsModels.LoadAboutDev.Response()
        presenter.presentAboutDev(response: response)
    }
    
    func loadCard(request: SettingsModels.LoadCard.Request) {
        let response = SettingsModels.LoadCard.Response()
        presenter.presentCard(response: response)
    }
    
    func loadNotification(request: SettingsModels.LoadNotification.Request) {
        if let notficationType = NotificationType(rawValue: request.notificationTitle),
        request.notificationTitle != "Custom" {
            let response = SettingsModels.LoadNotification.Response(
                id: request.id,
                notificationTitle: request.notificationTitle,
                notificationType: notficationType
            )
            presenter.presentNotification(response: response)
        } else {
            let response = SettingsModels.LoadNotification.Response(
                id: request.id,
                notificationTitle: request.notificationTitle,
                notificationType: .custom
            )
            presenter.presentNotification(response: response)
        }
    }
    
    func addCustomNotification(request: SettingsModels.AddCustomNotification.Request) {
        notificationsCustomTitles.append("")
        notificationsCustomStates.append(false)
        worker.saveCustomNotifications(notificationsCustomTitles)
        worker.saveCustomNotificationsStates(notificationsCustomStates)
        let response = SettingsModels.AddCustomNotification.Response()
        presenter.presentCustomNotification(response: response)
    }
    
    func deleteCustomNotification(request: SettingsModels.DeleteCustomNotification.Request) {
        notificationsCustomTitles.remove(at: request.index)
        notificationsCustomStates.remove(at: request.index)
        worker.saveCustomNotifications(notificationsCustomTitles)
        worker.saveCustomNotificationsStates(notificationsCustomStates)
        let response = SettingsModels.DeleteCustomNotification.Response(index: request.index)
        presenter.presentNotificationsAfterDeletion(response: response)
    }
    
    func syncNotifications(request: SettingsModels.SyncNotifications.Request) {
        let states = worker.loadDefaultNotificationsStates()
        
        for (index, isEnabled) in states.enumerated() where isEnabled {
            switch index {
            case 0:
                worker.disableNotifications(notificationType: .drink)
                worker.enableNotifications(notificationType: .drink)
            case 1:
                worker.disableNotifications(notificationType: .food)
                worker.enableNotifications(notificationType: .food)
            case 2:
                worker.disableNotifications(notificationType: .sleep)
                worker.enableNotifications(notificationType: .sleep)
            default: break
            }
        }
        
        let response = SettingsModels.SyncNotifications.Response()
        presenter.presentSyncNotifications(response: response)
    }
    
    func syncCustomNotifications(request: SettingsModels.SyncCustomNotifications.Request) {
        let states = worker.loadCustomNotificationsStates()
        let titles = worker.loadCustomNotifications()
        for (index, isEnabled) in states.enumerated() where isEnabled {
            worker.disableNotifications(notificationType: .custom)
            worker.enableNotifications(notificationType: .custom, customTitle: titles[index])
        }
        
        let response = SettingsModels.SyncCustomNotifications.Response()
        presenter.presentSyncCustomNotifications(response: response)
    }
}

// MARK: - UITableViewDataSource
extension SettingsInteractor: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.numberOfRowsCard
        case 1:
            return Constants.numberOfRowsNotificationsDefault
        case 2:
            return notificationsCustomTitles.count
        case 3:
            return Constants.numberOfRowsNotificationsCreation
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath)
            
            guard let settingsCell = cell as? SettingsCell else {
                return cell
            }
            settingsCell.configure(with: "Medical Card", true)
            return settingsCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath)
            
            guard let settingsCell = cell as? SettingsCell else {
                return cell
            }
            
            settingsCell.switchValueChanged = { [weak self] isOn in
                switch indexPath.row {
                case 0:
                    self?.worker.disableNotifications(notificationType: .drink)
                    if isOn { 
                        self?.worker.enableNotifications(notificationType: .drink)
                    }
                case 1:
                    self?.worker.disableNotifications(notificationType: .food)
                    if isOn { 
                        self?.worker.enableNotifications(notificationType: .food)
                    }
                case 2:
                    self?.worker.disableNotifications(notificationType: .sleep)
                    if isOn { 
                        self?.worker.enableNotifications(notificationType: .sleep)
                    }
                default: 
                    break
                }
                self?.notificationsDefaultStates[indexPath.row] = isOn
                self?.worker.saveDefaultNotificationsStates(self?.notificationsDefaultStates ?? [])
            }
            
            settingsCell.configure(
                with: Constants.notificationsDefaultTitles[indexPath.row],
                false,
                notificationsDefaultStates[indexPath.row]
            )
            return settingsCell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath)
            
            guard let settingsCell = cell as? SettingsCell else {
                return cell
            }
            
            settingsCell.textFieldValueChanged = { [weak self] updatedText in 
                if indexPath.row < self?.notificationsCustomTitles.count ?? 0 {
                    self?.notificationsCustomTitles[indexPath.row] = updatedText
                    self?.worker.saveCustomNotifications(self?.notificationsCustomTitles ?? [])
                }
            }
            
            settingsCell.switchValueChanged = { [weak self] isOn in
                self?.worker.disableNotifications(notificationType: .custom)
                if isOn { 
                    self?.worker.enableNotifications(
                        notificationType: .custom,
                        customTitle: settingsCell.settingsTextField.text
                    )
                }
                if indexPath.row < self?.notificationsCustomTitles.count ?? 0 {
                    self?.notificationsCustomStates[indexPath.row] = isOn
                    self?.worker.saveCustomNotificationsStates(self?.notificationsCustomStates ?? [])
                }
            }
            
            settingsCell.configure(
                with: notificationsCustomTitles[indexPath.row],
                false,
                notificationsCustomStates[indexPath.row],
                customNotification: true
            )
            return settingsCell
        case 3:
            let extraCell = tableView.dequeueReusableCell(withIdentifier: AddNotificationCell.reuseId, for: indexPath)
            
            guard let notificationCell = extraCell as? AddNotificationCell else {
                return extraCell
            }
            
            return notificationCell
        default:
            return AddNotificationCell()
        }
    }
}
