//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit
import UserNotifications

final class SettingsViewController: UIViewController, SettingsDisplayLogic {    
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 155
        
        static let buttonTitleWidth: CGFloat = 120
        static let buttonTitleOffsetLeft: CGFloat = 63
        
        static let buttonOffsetH: CGFloat = 100
        static let buttonHeight: CGFloat = 45
        static let buttonOffsetBottom: CGFloat = 45
        static let buttonCornerRadius: CGFloat = 20
        static let buttonImageOffsetRight: CGFloat = 5
        static let buttonImageOffsetTop: CGFloat = 15
        
        static let heightForRow: CGFloat = 60
        
        static let settingsTableOffsetTop: CGFloat = -5
        
        static let customNotificationsSection: Int = 2
        
        static let tableTitleFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
        static let tableTitleOffsetH: CGFloat = 15
        static let tableTitleOffsetV: CGFloat = 5
        static let tableTitleHeight: CGFloat = 22
    }
    
    // MARK: - Properties
    var interactor: SettingsBuisnessLogic
    var router: SettingsRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }()
    
    let aboutDevButton: UIButton = UIButton(type: .system)
    var settingsTable: UITableView = UITableView()
    
    // MARK: - Initialization
    init(interactor: SettingsBuisnessLogic, router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestNotificationPermission()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = SettingsModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: SettingsModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel, true)
        view.addSubview(navigationBar)
        
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        configureAboutDevButton(with: viewModel)
        configureSettingsTable()
    }
    
    func displayAboutDev(viewModel: SettingsModels.LoadAboutDev.ViewModel) {
        router.showAboutDevScreen()
    }
    
    func displayCard(viewModel: SettingsModels.LoadCard.ViewModel) {
        router.showCardScreen()
    }
    
    func displayNotification(viewModel: SettingsModels.LoadNotification.ViewModel) {
        router.showNotificationScreen(viewModel.notification)
    }
    
    func displayCustomNotification(viewModel: SettingsModels.AddCustomNotification.ViewModel) {
        settingsTable.insertRows(
            at: [IndexPath(row: settingsTable.numberOfRows(inSection: Constants.customNotificationsSection), section: Constants.customNotificationsSection)],
            with: .left
        )
    }
    
    func displayNotificationsAfterDeletion(viewModel: SettingsModels.DeleteCustomNotification.ViewModel) {
        settingsTable.deleteRows(
            at: [IndexPath(row: viewModel.index, section: Constants.customNotificationsSection)],
            with: .left
        )
    }
    
    func displaySyncNotifications(viewModel: SettingsModels.SyncNotifications.ViewModel) {
        
    }
    
    func displaySyncCustomNotifications(viewModel: SettingsModels.SyncCustomNotifications.ViewModel) {
        
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = .backgroundPrimary
        configureNavigationItems()
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureAboutDevButton(with viewModel: SettingsModels.LoadStart.ViewModel) {
        view.addSubview(aboutDevButton)
        
        aboutDevButton.setHeight(Constants.buttonHeight)
        aboutDevButton.pinHorizontal(to: view, Constants.buttonOffsetH)
        aboutDevButton.pinBottom(to: view.bottomAnchor, Constants.buttonOffsetBottom)
        
        aboutDevButton.setTitle(viewModel.buttonTitle, for: .normal)
        aboutDevButton.titleLabel?.textAlignment = .center
        aboutDevButton.titleLabel?.font = viewModel.buttonTitleFont
        aboutDevButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        aboutDevButton.backgroundColor = viewModel.buttonColor
        aboutDevButton.layer.cornerRadius = Constants.buttonCornerRadius
        aboutDevButton.addTarget(self, action: #selector(aboutDevButtonPressed), for: .touchUpInside)
    }
    
    private func configureSettingsTable() {
        settingsTable.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        settingsTable.register(AddNotificationCell.self, forCellReuseIdentifier: AddNotificationCell.reuseId)
        settingsTable.delegate = self
        settingsTable.dataSource = interactor
        
        settingsTable.backgroundColor = .clear
        settingsTable.separatorStyle = .none
        settingsTable.allowsSelection = true
        
        view.addSubview(settingsTable)
        settingsTable.pinHorizontal(to: view)
        settingsTable.pinBottom(to: aboutDevButton.topAnchor)
        settingsTable.pinTop(to: navigationBar.bottomAnchor, Constants.settingsTableOffsetTop)
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка запроса разрешения на уведомления: \(error)")
            } else {
                print("Разрешение на уведомления: \(granted ? "разрешено" : "запрещено")")
            }
        }
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    private func synchronizeNotifications(with viewModel: SettingsModels.LoadStart.ViewModel) {
        let defaultRequest = SettingsModels.SyncNotifications.Request()
        interactor.syncNotifications(request: defaultRequest)
        
        let customRequest = SettingsModels.SyncCustomNotifications.Request()
        interactor.syncCustomNotifications(request: customRequest)
    }
    
    // MARK: - Actions
    @objc func aboutDevButtonPressed() {
        triggerSelectionFeedback()
        let request = SettingsModels.LoadAboutDev.Request()
        interactor.loadAboutDev(request: request)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
        switch indexPath.section {
        case 0:
            let request = SettingsModels.LoadCard.Request()
            interactor.loadCard(request: request)
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else {
                return
            }
            let settingsTitle = cell.settingsLabel.text ?? ""
            let request = SettingsModels.LoadNotification.Request(id: indexPath.row, notificationTitle: settingsTitle)
            interactor.loadNotification(request: request)
        case 2:
            guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else {
                return
            }
            
            let settingsTitle = cell.settingsTextField.text ?? ""
            let request = SettingsModels.LoadNotification.Request(
                id: indexPath.row,
                notificationTitle: settingsTitle
            )
            interactor.loadNotification(request: request)
        case 3:
            let index = tableView.numberOfRows(inSection: 2)
            
            let request = SettingsModels.AddCustomNotification.Request(index: index)
            interactor.addCustomNotification(request: request)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 2 else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completionHandler in 
            let request = SettingsModels.DeleteCustomNotification.Request(index: indexPath.row)
            self?.interactor.deleteCustomNotification(request: request)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .backgroundPrimary
        deleteAction.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        let titleLabel = UILabel()
        
        switch section {
        case 1:
            titleLabel.text = "Default notifications"
        case 2:
            titleLabel.text = "Custom notifications"
        default:
            return headerView
        }
        
        titleLabel.font = Constants.tableTitleFont
        titleLabel.textColor = UIColor.parametersTitleLabel
        titleLabel.frame = CGRect(
            x: Constants.tableTitleOffsetH,
            y: -Constants.tableTitleOffsetV,
            width: tableView.frame.width,
            height: Constants.tableTitleHeight
        )
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return Constants.tableTitleHeight
        case 2:
            return Constants.tableTitleHeight
        default:
            return .zero
        }
    }
}
