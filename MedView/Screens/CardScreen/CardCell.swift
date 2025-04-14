//
//  CardCell.swift
//  MedView
//
//  Created by Алексей on 14.04.2025.
//

import UIKit
import Foundation

final class CardCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let parameterLabelOffsetLeft: CGFloat = 25
        static let textFont: UIFont = .systemFont(ofSize: 20)
        
        static let textFieldOffsetLeft: CGFloat = 5
    }
    
    // MARK: - Properties
    static let reuseId: String = "CardCell"
    
    var parameterLabel: UILabel = UILabel()
    var valueTextField: UITextField = UITextField()
    
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
    public func configure(with parameterTitle: String, _ value: String) {
        parameterLabel.text = parameterTitle
        valueTextField.placeholder = parameterTitle
        valueTextField.text = value
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .gray
        backgroundColor = .cellBackground
        
        configureLabel()
        configureTextField()
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
        valueTextField.pinLeft(to: parameterLabel.trailingAnchor, Constants.textFieldOffsetLeft)
        valueTextField.pinRight(to: contentView.trailingAnchor)
        
        valueTextField.placeholder = "Value"
        valueTextField.font = Constants.textFont
        valueTextField.tintColor = .main
        valueTextField.textColor = .textPrimary
    }
}
