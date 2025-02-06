//
//  SettingsView.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class SettingsView: UIView {
    // MARK: - Variables
    let settingsNavigation: SettingsNavigationBarView = SettingsNavigationBarView()
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = UIColor().hexToRGB(hex: Constants.backgroundLightHex)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        addSubview(settingsNavigation)
        
        settingsNavigation.pinTop(to: self.topAnchor)
        settingsNavigation.setHeight(Constants.SettingsView.settingsNavigationBarHeight)
        settingsNavigation.pinLeft(to: self.leadingAnchor)
        settingsNavigation.pinRight(to: self.trailingAnchor)
    }
}
