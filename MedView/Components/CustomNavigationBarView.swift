//
//  CustomNavigationBarView.swift
//  MedView
//
//  Created by Алексей on 09.02.2025.
//

import Foundation
import UIKit

final class CustomNavigationBarView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarBorderlineHeight: CGFloat = 1
        static let titleLabelFontSize: CGFloat = 36
        static let titleLabelHeight: CGFloat = 44
        static let settingsButtonSize: CGFloat = 44
        static let navigationBarItemOffset: CGFloat = 20
        
        static let settingsSymbol: String = "SettingsSymbol"
        
        static let customTitleOffsetRight: CGFloat = -100
    }
    // MARK: - Variables
    var title: UILabel = UILabel()
    var settingsButton: UIButton = UIButton(type: .custom)
    var defaultNavigationTitles: [NSMutableAttributedString] = [
        NSMutableAttributedString("MedView"),
        NSMutableAttributedString("Assistant")
    ]
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with viewModel: NavigationTitleRepresentable, _ isSettingsButtonHidden: Bool = false) {
        title.attributedText = viewModel.navigationTitle
        if let navigationTitleColor = viewModel.navigationTitleColor {
            title.textColor = navigationTitleColor
        }
        title.font = viewModel.navigationTitleFont
        configureTitle(with: viewModel)
        
        backgroundColor = viewModel.navigationBackgroundColor
        if isSettingsButtonHidden == false {
            settingsButton.setImage(viewModel.settingsImage, for: .normal)
            configureButton()
        }
    }
    
    func configure(with viewModel: NavigationTitleRepresentable, _ animatedIcon: UIView) {
        configure(with: viewModel)
        addSubview(animatedIcon)
        animatedIcon.pinLeft(to: title.trailingAnchor)
        animatedIcon.pinBottom(to: self, Constants.navigationBarItemOffset)
    }
    
    public func settingsButtonTarget(target: UIViewController, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }
    // MARK: - Private functions
    private func configureTitle(with viewModel: NavigationTitleRepresentable) {
        addSubview(title)
        title.pinLeft(to: self.leadingAnchor, Constants.navigationBarItemOffset)
        title.setHeight(Constants.titleLabelHeight)
        title.pinBottom(to: self.bottomAnchor, Constants.navigationBarItemOffset)
        if defaultNavigationTitles.contains(viewModel.navigationTitle) {
            title.pinRight(to: self.centerXAnchor, Constants.navigationBarItemOffset)
        } else {
            title.pinRight(to: self.centerXAnchor, Constants.customTitleOffsetRight)
        }
    }
    
    private func configureButton() {
        addSubview(settingsButton)
        settingsButton.setWidth(Constants.settingsButtonSize)
        settingsButton.setHeight(Constants.settingsButtonSize)
        settingsButton.pinBottom(to: self, Constants.navigationBarItemOffset)
        settingsButton.pinRight(to: self, Constants.navigationBarItemOffset)
    }
    
}
