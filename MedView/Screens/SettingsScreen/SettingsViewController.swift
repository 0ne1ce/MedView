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
        static let buttonTitleOffsetLeft: CGFloat = 75
        
        static let buttonOffsetH: CGFloat = 100
        static let buttonHeight: CGFloat = 45
        static let buttonOffsetBottom: CGFloat = 45
        static let buttonCornerRadius: CGFloat = 20
        static let buttonImageOffsetRight: CGFloat = 5
        static let buttonImageOffsetTop: CGFloat = 15
        
        static let heightForRow: CGFloat = 60
        
        static let settingsTableOffsetTop: CGFloat = 10
    }
    
    // MARK: - Properties
    var interactor: SettingsBuisnessLogic
    var router: SettingsRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
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
        router.showNotificationScreen()
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = .backgroundPrimary
        configureNavigationItems()
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
        aboutDevButton.titleLabel?.font = viewModel.buttonTitleFont
        aboutDevButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        aboutDevButton.backgroundColor = viewModel.buttonColor
        aboutDevButton.layer.cornerRadius = Constants.buttonCornerRadius
        aboutDevButton.addTarget(self, action: #selector(aboutDevButtonPressed), for: .touchUpInside)
        
        if let buttonTitleLabel = aboutDevButton.titleLabel {
            buttonTitleLabel.pinRight(to: aboutDevButton.trailingAnchor)
            buttonTitleLabel.pinLeft(to: aboutDevButton.leadingAnchor, Constants.buttonTitleOffsetLeft)
            let imageView = UIImageView(image: viewModel.buttonImage)
            imageView.tintColor = viewModel.buttonImageTintColor
            aboutDevButton.addSubview(imageView)
            imageView.pinTop(to: buttonTitleLabel.topAnchor)
            imageView.pinBottom(to: buttonTitleLabel.bottomAnchor)
            imageView.pinRight(to: buttonTitleLabel.leadingAnchor, Constants.buttonImageOffsetRight)
        }
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
    
    func requestNotificationPermission() {
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
    
    // MARK: - Actions
    @objc func aboutDevButtonPressed() {
        triggerSelectionFeedback()
        let request = SettingsModels.LoadAboutDev.Request()
        interactor.loadAboutDev(request: request)
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            triggerSelectionFeedback()
            let request = SettingsModels.LoadCard.Request()
            interactor.loadCard(request: request)
        case 2:
            triggerSelectionFeedback()
            let request = SettingsModels.LoadNotification.Request()
            interactor.loadNotification(request: request)
        case 3:
            triggerSelectionFeedback()
            let request = SettingsModels.LoadNotification.Request()
            interactor.loadNotification(request: request)
        default:
            return
        }
    }
}
