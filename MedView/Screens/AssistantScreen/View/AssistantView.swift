//
//  AssistantView.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantView: UIView {
    // MARK: - Variables
    let assistantNavigation: CustomNavigationBarView = CustomNavigationBarView()
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
        addSubview(assistantNavigation)
        assistantNavigation.configure(with: Constants.AssistantView.assistantLabelText, isSettingsButtonHidden: false)
        assistantNavigation.pinTop(to: self.topAnchor)
        assistantNavigation.setHeight(Constants.CustomNavigationBarView.navigationBarHeight)
        assistantNavigation.pinLeft(to: self.leadingAnchor)
        assistantNavigation.pinRight(to: self.trailingAnchor)
    }
}
