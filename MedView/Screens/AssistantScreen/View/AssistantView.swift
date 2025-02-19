//
//  AssistantView.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 120
    }
    // MARK: - Variables
    let assistantNavigation: CustomNavigationBarView = CustomNavigationBarView()
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = UIColor(hex: AssistantConstants.backgroundLightHex)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        addSubview(assistantNavigation)
        assistantNavigation.configure(with: AssistantConstants.assistantLabelText)
        assistantNavigation.pinTop(to: self.topAnchor)
        assistantNavigation.setHeight(Constants.navigationBarHeight)
        assistantNavigation.pinLeft(to: self.leadingAnchor)
        assistantNavigation.pinRight(to: self.trailingAnchor)
    }
}
