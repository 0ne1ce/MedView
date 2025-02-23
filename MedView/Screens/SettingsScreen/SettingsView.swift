//
//  SettingsView.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//
//
//import Foundation
//import UIKit
//
//final class SettingsView: UIView {
//    // MARK: - Variables
//    let settingsNavigation: CustomNavigationBarView = CustomNavigationBarView()
//    // MARK: - Initialization
//    init() {
//        super.init(frame: .zero)
//        configureUI()
//    }
//    
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Private functions
//    private func configureUI() {
//        backgroundColor = UIColor(hex: SettingsConstants.backgroundLightHex)
//        configureNavigationBar()
//    }
//    
//    private func configureNavigationBar() {
//        addSubview(settingsNavigation)
//        //settingsNavigation.configure(with: SettingsConstants.settingsLabelText, true)
//        settingsNavigation.pinTop(to: self.topAnchor)
//        settingsNavigation.setHeight(SettingsConstants.settingsNavigationBarHeight)
//        settingsNavigation.pinLeft(to: self.leadingAnchor)
//        settingsNavigation.pinRight(to: self.trailingAnchor)
//    }
//}
