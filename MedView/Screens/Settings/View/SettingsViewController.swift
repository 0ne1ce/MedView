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
        view.backgroundColor = UIColor().hexToRGB(hex: Constants.backgroundLightHex)
    }
}
