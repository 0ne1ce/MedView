//
//  AssistantViewController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantViewController: UIViewController, AssistantDisplayLogic {
    // MARK: - Properties
    var interactor: (AssistantBuisnessLogic & AssistantDataStore)?
    var router: AssistantRouterProtocol?
    var assistantView: AssistantView = AssistantView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = assistantView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private functions
    private func configure() {
        configureButtonTarget()
    }
    
    private func configureButtonTarget() {
        assistantView.assistantNavigation.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        router?.showSettingsScreen()
    }
}
