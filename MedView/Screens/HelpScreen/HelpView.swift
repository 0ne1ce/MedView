//
//  HelpView.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 120
    }
    // MARK: - Variables
    let helpNavigation: CustomNavigationBarView = CustomNavigationBarView()
    var guideText: UILabel = UILabel()
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
        backgroundColor = UIColor(hex: HelpConstants.backgroundLightHex)
        configureNavigationBar()
        configureText()
    }
    
    private func configureNavigationBar() {
        helpNavigation.configure(with: HelpConstants.helpLabelText)
        addSubview(helpNavigation)
        
        helpNavigation.pinTop(to: self.topAnchor)
        helpNavigation.setHeight(Constants.navigationBarHeight)
        helpNavigation.pinLeft(to: self.leadingAnchor)
        helpNavigation.pinRight(to: self.trailingAnchor)
    }
    
    private func configureText() {
        guideText.text = HelpConstants.guideTextContent
        guideText.font = HelpConstants.guideTextFont
        guideText.textColor = .black
        guideText.textAlignment = .center
        guideText.lineBreakMode = .byWordWrapping
        guideText.numberOfLines = HelpConstants.guideTextLimit
        
        addSubview(guideText)
        
        guideText.pinTop(to: helpNavigation.bottomAnchor)
        guideText.pinBottom(to: self.bottomAnchor)
        guideText.pinLeft(to: self.leadingAnchor)
        guideText.pinRight(to: self.trailingAnchor)
    }
}
