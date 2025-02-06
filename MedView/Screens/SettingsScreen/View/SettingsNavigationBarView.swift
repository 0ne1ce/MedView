//
//  SettingsNavigationBarView.swift
//  MedView
//
//  Created by Алексей on 07.02.2025.
//

import Foundation
import UIKit

final class SettingsNavigationBarView: UIView {
    // MARK: - Properties
    let borderline: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    let settingsButton: UIButton = UIButton(type: .custom)
    
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
        borderline.backgroundColor = .lightGray
        addSubview(borderline)
        borderline.pinBottom(to: self.bottomAnchor)
        borderline.pinLeft(to: self.leadingAnchor)
        borderline.pinRight(to: self.trailingAnchor)
        borderline.setHeight(Constants.CustomNavigationBarView.navigationBarBorderlineHeight)
    }
    
    private func configureTitle() {
        let font = UIFont.systemFont(ofSize: Constants.CustomNavigationBarView.titleLabelFontSize)
        titleLabel.font = font.bold
        titleLabel.textColor = .black
        
        addSubview(titleLabel)
        titleLabel.pinLeft(to: self.leadingAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        titleLabel.setHeight(Constants.CustomNavigationBarView.titleLabelHeight)
        titleLabel.pinBottom(to: self.bottomAnchor, Constants.CustomNavigationBarView.navigationBarItemOffset)
        titleLabel.pinRight(to: self.trailingAnchor)
    }
    
    private func configureButton() {
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
    }
    
    // MARK: - Public functions
    func configure(with viewModel: CustomNavigationBarViewModel) {
        backgroundColor = viewModel.backgroundColor
        
        if let attributedTitle = viewModel.attributedTitle {
            titleLabel.attributedText = attributedTitle
            configureTitle()
        } else if let title = viewModel.title {
            titleLabel.text = title
            configureTitle()
        } else {
            titleLabel.text = nil
        }
        
        
        
        if viewModel.isSettingsButtonHidden == false {
            configureButton()
        }
    }
    
    public func settingsButtonTarget(target: UIViewController, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
