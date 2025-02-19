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
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
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
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .systemMint
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemMint]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
