//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController, SettingsDisplayLogic {
    // MARK: - Properties
    var interactor: (SettingsBuisnessLogic & SettingsDataStore)?
    var router: SettingsRouterProtocol?
    var settingsView: SettingsView = SettingsView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private functions
    private func configure() {
        interactor?.configureNavigationBar()
    }
    
    private func configureButtonTarget() {
        settingsView.settingsNavigation.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    // MARK: - Public functions
    func displayNavigationBar(with viewModel: CustomNavigationBarViewModel) {
        if (viewModel.isSettingsButtonHidden == false) {
            configureButtonTarget()
        }
        settingsView.settingsNavigation.configure(with: viewModel)
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        
    }
}
