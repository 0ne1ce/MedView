//
//  CustomNavigationBarView.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class CustomNavigationBarView: UIView {
    // MARK: - Properties
    let borderline: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    let settingsButton: UIButton = UIButton(type: .custom)
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configure() {
        backgroundColor = .white
        
        borderline.backgroundColor = .lightGray
        addSubview(borderline)
        borderline.pinBottom(to: self.bottomAnchor)
        borderline.pinLeft(to: self.leadingAnchor)
        borderline.pinRight(to: self.trailingAnchor)
        borderline.setHeight(Constants.CustomNavigationBarView.navigationBarBorderlineHeight)
        
                let settingsImage = UIImage(named: Constants.CustomNavigationBarView.settingsSymbol)
                settingsButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.CustomNavigationBarView.settingsButtonSize)
                settingsButton.setTitleColor(.systemMint, for: .normal)
                settingsButton.backgroundColor = .clear
                settingsButton.setImage(settingsImage, for: .normal)
        
                addSubview(settingsButton)
                settingsButton.setWidth(Constants.CustomNavigationBarView.settingsButtonSize)
                settingsButton.setHeight(Constants.CustomNavigationBarView.settingsButtonSize)
        settingsButton.pinBottom(to: self.bottomAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        settingsButton.pinRight(to: self.trailingAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        
        configureTitle()
    }
    
    private func configureTitle() {
        let titleLabelText = Constants.ParametersView.medViewLabelText
        let attributedMedViewText = NSMutableAttributedString(string: titleLabelText)
        attributedMedViewText.addAttribute(.foregroundColor, value: UIColor.systemMint, range: NSRange(location: Constants.ParametersView.mintColorStringLocation, length: Constants.ParametersView.mintColorStringLength))
        titleLabel.attributedText = attributedMedViewText
        let font = UIFont.systemFont(ofSize: Constants.CustomNavigationBarView.titleLabelFontSize)
        titleLabel.font = font.italicBold
        
        
        addSubview(titleLabel)
        titleLabel.pinLeft(to: self.leadingAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        titleLabel.setHeight(Constants.CustomNavigationBarView.titleLabelFontSize)
        titleLabel.pinBottom(to: self.bottomAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        titleLabel.pinRight(to: self.centerXAnchor)
    }
}
