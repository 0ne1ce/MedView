//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class NotificationViewController: UIViewController, NotificationDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let mainColorHex: String = "00C7C0"
        
        static let navigationBarHeight: CGFloat = 155
    }
    
    // MARK: - Properties
    var interactor: NotificationBuisnessLogic
    var router: NotificationRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    let aboutDevButton: UIButton = UIButton(type: .system)
    var settingsTable: UITableView = UITableView()
    
    // MARK: - Initialization
    init(interactor: NotificationBuisnessLogic, router: NotificationRouterProtocol) {
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
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = NotificationModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: NotificationModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel, true)
        view.addSubview(navigationBar)
        
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = UIColor(hex: Constants.backgroundLightHex)
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = UIColor(hex: Constants.mainColorHex)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(hex: Constants.mainColorHex)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
