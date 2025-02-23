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
        static let titleLabelHeight: CGFloat = 40
        static let settingsButtonSize: CGFloat = 40
        static let navigationBarItemOffset: CGFloat = 20
        
        static let settingsSymbol: String = "SettingsSymbol"
    }
    // MARK: - Variables
    var borderline: UIView = UIView()
    var title: UILabel = UILabel()
    var settingsButton: UIButton = UIButton(type: .custom)
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func confiugre(with viewModel: NavigationTitleRepresentable, _ isSettingsButtonHidden: Bool = false) {
        title.attributedText = viewModel.navigationTitle
        title.font = viewModel.navigationTitleFont
        configureTitle()
        
        backgroundColor = viewModel.navigationBackgroundColor
        borderline.backgroundColor = viewModel.borderlineColor
        configureBorderline()
        if isSettingsButtonHidden == false {
            settingsButton.setImage(viewModel.settingsImage, for: .normal)
            configureButton()
        }
    }
    
    public func settingsButtonTarget(target: UIViewController, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }
    // MARK: - Private functions
    private func configureBorderline() {
        addSubview(borderline)
        borderline.pinBottom(to: self)
        borderline.pinLeft(to: self)
        borderline.pinRight(to: self)
        borderline.setHeight(Constants.navigationBarBorderlineHeight)
    }
    
    private func configureTitle() {
        addSubview(title)
        title.pinLeft(to: self, Constants.navigationBarItemOffset)
        title.setHeight(Constants.titleLabelHeight)
        title.pinBottom(to: self, Constants.navigationBarItemOffset)
        title.pinRight(to: self)
    }
    
    private func configureButton() {
        addSubview(settingsButton)
        settingsButton.setWidth(Constants.settingsButtonSize)
        settingsButton.setHeight(Constants.settingsButtonSize)
        settingsButton.pinBottom(to: self, Constants.navigationBarItemOffset)
        settingsButton.pinRight(to: self, Constants.navigationBarItemOffset)
    }
    
}
