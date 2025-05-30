//
//  SettingsCell.swift
//  MedView
//
//  Created by Алексей on 13.04.2025.
//

import UIKit
import Foundation
import Lottie

final class SettingsCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapRadius: CGFloat = 10
        static let wrapOffsetH: CGFloat = 10
        static let wrapOffsetV: CGFloat = 5
        
        static let settingsLabelOffsetLeft: CGFloat = 25
        static let settingsLabelOffsetRight: CGFloat = 65
        static let settingsLabelFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        
        static let animationName: String = "HealthLoadAnimation"
        static let animationSize: CGFloat = 30
        static let animationOffsetLeft: CGFloat = 10
        
        static let placeholderName: String = "Name"
        static let settingsTextFieldOffsetRight: CGFloat = 100
    }
    
    // MARK: - Properties
    static let reuseId: String = "SettingsCell"
    
    var settingsWrap: UIView = UIView()
    var settingsLabel: UILabel = UILabel()
    var settingsTextField: UITextField = UITextField()
    var settingsSwitch: UISwitch = UISwitch()
    
    var switchValueChanged: ((Bool) -> Void)?
    var textFieldValueChanged: ((String) -> Void)?
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingsTextField.delegate = self
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    public func configure(with title: String, _ isToggleHidden: Bool = false, _ toggleIsOn: Bool = false, customNotification: Bool = false) {
        settingsLabel.isHidden = false
        settingsTextField.isHidden = true
        settingsSwitch.isHidden = true
        
        for subview in settingsWrap.subviews where subview is LottieAnimationView {
            subview.removeFromSuperview()
        }

        settingsLabel.text = title
        
        if isToggleHidden {
            configureAnimation()
        } else {
            settingsSwitch.isHidden = false
            configureToggle(toggleIsOn)
        }

        if customNotification {
            settingsLabel.isHidden = true
            settingsTextField.isHidden = false
            settingsTextField.text = title
            configureTextField()
        }
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        configureWrap()
        configureLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(settingsWrap)
        settingsWrap.pinVertical(to: contentView, Constants.wrapOffsetV)
        settingsWrap.pinHorizontal(to: contentView, Constants.wrapOffsetH)
        
        settingsWrap.layer.cornerRadius = Constants.wrapRadius
        settingsWrap.backgroundColor = .cellBackground
    }
    
    private func configureLabel() {
        settingsWrap.addSubview(settingsLabel)
        
        settingsLabel.pinTop(to: settingsWrap.layoutMarginsGuide.topAnchor)
        settingsLabel.pinBottom(to: settingsWrap.layoutMarginsGuide.bottomAnchor)
        settingsLabel.pinLeft(to: settingsWrap, Constants.settingsLabelOffsetLeft)
        settingsLabel.pinRight(to: settingsWrap, Constants.settingsLabelOffsetRight)
        
        settingsLabel.textColor = .textPrimary
        settingsLabel.textAlignment = .left
        settingsLabel.font = Constants.settingsLabelFont
        settingsLabel.text = "Error"
    }
    
    private func configureAnimation() {
        let animationView = LottieAnimationView(name: Constants.animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .autoReverse
        animationView.play()
        settingsWrap.addSubview(animationView)
        animationView.pinLeft(to: settingsLabel.trailingAnchor, Constants.animationOffsetLeft)
        animationView.pinTop(to: settingsWrap.layoutMarginsGuide.topAnchor)
        animationView.setWidth(Constants.animationSize)
        animationView.setHeight(Constants.animationSize)
    }
    
    private func configureToggle(_ toggleState: Bool) {
        settingsWrap.addSubview(settingsSwitch)
        settingsSwitch.pinLeft(to: settingsLabel.trailingAnchor)
        settingsSwitch.pinTop(to: settingsWrap.layoutMarginsGuide.topAnchor)
        settingsSwitch.pinBottom(to: settingsWrap.layoutMarginsGuide.bottomAnchor)
        settingsSwitch.isOn = toggleState
        settingsSwitch.addTarget(self, action: #selector(switchPressed), for: .valueChanged)
        settingsSwitch.onTintColor = .main
    }
    
    private func configureTextField() {
        settingsLabel.isHidden = true
        settingsWrap.addSubview(settingsTextField)
        settingsTextField.pinLeft(to: settingsLabel.leadingAnchor)
        settingsTextField.pinRight(to: settingsSwitch.leadingAnchor, Constants.settingsTextFieldOffsetRight)
        settingsTextField.pinVertical(to: settingsLabel)
        
        settingsTextField.font = settingsLabel.font
        settingsTextField.placeholder = Constants.placeholderName
        settingsTextField.tintColor = .main
        settingsTextField.textColor = .textPrimary
    }
    
    // MARK: - Actions
    @objc private func switchPressed(_ sender: UISwitch) {
        switchValueChanged?(sender.isOn)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldValueChanged?(textField.text ?? "")
    }
}
