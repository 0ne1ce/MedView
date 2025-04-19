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
        
        static let addTimeImage: UIImage? = UIImage(named: "PlusSymbol")
    }
    // MARK: - Variables
    var title: UILabel = UILabel()
    var button: UIButton = UIButton(type: .custom)
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
    func configure(with viewModel: NavigationTitleRepresentable, _ isButtonHidden: Bool = false, _ isAddTimeButton: Bool = false) {
        title.attributedText = viewModel.navigationTitle
        if let navigationTitleColor = viewModel.navigationTitleColor {
            title.textColor = navigationTitleColor
        }
        title.font = viewModel.navigationTitleFont
        configureTitle(with: viewModel)
        
        backgroundColor = .cellBackground
        if isButtonHidden == false {
            configureButton()
            if isAddTimeButton {
                button.setImage(Constants.addTimeImage, for: .normal)
                title.pinRight(to: button.leadingAnchor)
            } else {
                button.setImage(viewModel.settingsImage, for: .normal)
                if defaultNavigationTitles.contains(viewModel.navigationTitle) {
                    title.pinRight(to: self.centerXAnchor, Constants.navigationBarItemOffset)
                } else {
                    title.pinRight(to: self.centerXAnchor, Constants.customTitleOffsetRight)
                }
            }
        }
    }
    
    func configure(with viewModel: NavigationTitleRepresentable, _ animatedIcon: UIView) {
        configure(with: viewModel)
        addSubview(animatedIcon)
        animatedIcon.pinLeft(to: title.trailingAnchor)
        animatedIcon.pinBottom(to: self, Constants.navigationBarItemOffset)
    }
    
    public func buttonTarget(target: UIViewController, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    // MARK: - Private functions
    private func configureTitle(with viewModel: NavigationTitleRepresentable) {
        addSubview(title)
        title.pinLeft(to: self.leadingAnchor, Constants.navigationBarItemOffset)
        title.setHeight(Constants.titleLabelHeight)
        title.pinBottom(to: self.bottomAnchor, Constants.navigationBarItemOffset)
    }
    
    private func configureButton() {
        addSubview(button)
        button.setWidth(Constants.settingsButtonSize)
        button.setHeight(Constants.settingsButtonSize)
        button.pinBottom(to: self, Constants.navigationBarItemOffset)
        button.pinRight(to: self, Constants.navigationBarItemOffset)
    }
    
}
