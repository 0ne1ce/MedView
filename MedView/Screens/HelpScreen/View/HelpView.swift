//
//  HelpView.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpView: UIView {
    // MARK: - Variables
    let helpNavigation: AssistantNavigationBarView = AssistantNavigationBarView()
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
        addSubview(helpNavigation)
        
        helpNavigation.pinTop(to: self.topAnchor)
        helpNavigation.setHeight(Constants.CustomNavigationBarView.navigationBarHeight)
        helpNavigation.pinLeft(to: self.leadingAnchor)
        helpNavigation.pinRight(to: self.trailingAnchor)
    }
}
