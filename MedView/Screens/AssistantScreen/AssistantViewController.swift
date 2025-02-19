//
//  AssistantViewController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantViewController: UIViewController, AssistantDisplayLogic {
    // MARK: - Constants
    enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let navigationBarHeight: CGFloat = 120
    }
    // MARK: - Properties
    var interactor: AssistantBuisnessLogic
    var router: AssistantRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Initialization
    init(interactor: AssistantBuisnessLogic, router: AssistantRouterProtocol) {
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadStart()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = AssistantModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AssistantModels.LoadStart.ViewModel) {
        navigationBar.confiugre(with: viewModel)
        configureSettingsButtonTarget()
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
    }
    
    func displaySettings(viewModel: AssistantModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = UIColor(hex: Constants.backgroundLightHex)
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = AssistantModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
    
}
