//
//  CardCell.swift
//  MedView
//
//  Created by Алексей on 14.04.2025.
//

import UIKit
import Foundation

final class TimeSetupCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let parameterLabelOffsetLeft: CGFloat = 25
        static let textFont: UIFont = .systemFont(ofSize: 20)
        
        static let textFieldOffsetRight: CGFloat = 20
        
        static let repeatSwitchOffsetRight: CGFloat = 20
        static let repeatSwitchOffsetBottom: CGFloat = 8
    }
    
    // MARK: - Properties
    static let reuseId: String = "TimeSetupCell"
    
    var parameterLabel: UILabel = UILabel()
    var valueTextField: UITextField = UITextField()
    var repeatSwitch: UISwitch = UISwitch()
    var switchValueChanged: ((Bool) -> Void)?
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    public func configure(with parameterTitle: String, _ value: String, index: Int, toggleState: Bool) {
        parameterLabel.text = parameterTitle
        if index == 0 {
            configureTextField()
        } else {
            configureToggle(toggleState)
        }
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .gray
        backgroundColor = .cellBackground
        
        configureLabel()
    }
    
    private func configureLabel() {
        contentView.addSubview(parameterLabel)
        
        parameterLabel.pinTop(to: contentView.layoutMarginsGuide.topAnchor)
        parameterLabel.pinBottom(to: contentView.layoutMarginsGuide.bottomAnchor)
        parameterLabel.pinLeft(to: contentView, Constants.parameterLabelOffsetLeft)
        parameterLabel.pinRight(to: contentView.centerXAnchor)
        
        parameterLabel.textColor = .textPrimary
        parameterLabel.textAlignment = .left
        parameterLabel.font = Constants.textFont
        parameterLabel.text = "Error"
    }
    
    private func configureTextField() {
        contentView.addSubview(valueTextField)
        
        valueTextField.pinTop(to: contentView.layoutMarginsGuide.topAnchor)
        valueTextField.pinBottom(to: contentView.layoutMarginsGuide.bottomAnchor)
        valueTextField.pinRight(to: contentView.trailingAnchor, Constants.textFieldOffsetRight)
        valueTextField.pinRight(to: contentView.trailingAnchor)
        
        valueTextField.placeholder = "Value"
        valueTextField.font = Constants.textFont
        valueTextField.tintColor = .main
        valueTextField.textColor = .textPrimary
        valueTextField.isUserInteractionEnabled = false
    }
    
    private func configureToggle(_ toggleState: Bool) {
        contentView.addSubview(repeatSwitch)
        repeatSwitch.pinRight(to: contentView.trailingAnchor, Constants.repeatSwitchOffsetRight)
        repeatSwitch.pinBottom(to: contentView.bottomAnchor, Constants.repeatSwitchOffsetBottom)
        repeatSwitch.isOn = toggleState
        repeatSwitch.addTarget(self, action: #selector(switchPressed), for: .valueChanged)
        repeatSwitch.onTintColor = .main
    }
    
    // MARK: - Actions
    @objc private func switchPressed(_ sender: UISwitch) {
        switchValueChanged?(sender.isOn)
    }
}
