//
//  ParameterCell.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class ParameterCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let parameterWrapRadius: CGFloat = 10
        static let parameterWrapOffsetV: CGFloat = 5
        static let parameterWrapOffsetH: CGFloat = 15
        
        static let parametersLabelFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        
        static let parametersLabelLeftOffset: CGFloat = 25
        static let parametersLabelRightOffset: CGFloat = 5
        
        static let iconLeftOffset: CGFloat = 15
        static let iconWidth: CGFloat = 20
    }
    // MARK: - Variables
    static let id = "ParameterCell"
    private let icon: UIImageView = UIImageView()
    let parametersLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()
    
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
    public func configure(with image: UIImage, and label: String) {
        self.icon.image = image
        self.parametersLabel.text = label
    }
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        configureWrap()
        configureImage()
        configureLabel()
    }
    
    private func configureWrap() {
        self.contentView.addSubview(wrap)
        wrap.backgroundColor = UIColor.cellBackground
        wrap.layer.cornerRadius = Constants.parameterWrapRadius
        
        wrap.pinTop(to: contentView, Constants.parameterWrapOffsetV)
        wrap.pinBottom(to: contentView, Constants.parameterWrapOffsetV)
        wrap.pinLeft(to: contentView, Constants.parameterWrapOffsetH)
        wrap.pinRight(to: contentView, Constants.parameterWrapOffsetH)
    }
    
    private func configureImage() {
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(systemName: "questionmark")
        icon.tintColor = .label
        
        wrap.addSubview(icon)
        
        icon.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        icon.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        icon.pinLeft(to: wrap, Constants.iconLeftOffset)
        icon.setWidth(Constants.iconWidth)
    }
    
    private func configureLabel() {
        parametersLabel.textColor = UIColor.textPrimary
        parametersLabel.textAlignment = .left
        parametersLabel.font = Constants.parametersLabelFont
        parametersLabel.text = "Error"
        
        wrap.addSubview(parametersLabel)
        
        parametersLabel.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        parametersLabel.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        parametersLabel.pinLeft(to: icon.trailingAnchor, Constants.parametersLabelLeftOffset)
        parametersLabel.pinRight(to: wrap, Constants.parametersLabelRightOffset)
    }
}
