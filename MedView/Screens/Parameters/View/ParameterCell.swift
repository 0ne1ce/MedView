//
//  ParameterCell.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class ParameterCell: UITableViewCell {
    // MARK: - Variables
    static let id = "ParameterCell"
    
    private let icon: UIImageView = UIImageView()
    
    private let parametersLabel: UILabel = UILabel()
    
    private let wrap: UIView = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = .clear
        self.contentView.addSubview(wrap)
        wrap.backgroundColor = .white
        wrap.layer.cornerRadius = Constants.ParametersView.parameterWrapRadius
        
        wrap.pinTop(to: self.contentView.topAnchor, Constants.ParametersView.parameterWrapOffsetV)
        wrap.pinBottom(to: self.contentView.bottomAnchor, Constants.ParametersView.parameterWrapOffsetV)
        wrap.pinLeft(to: self.contentView.leadingAnchor, Constants.ParametersView.parameterWrapOffsetH)
        wrap.pinRight(to: self.contentView.trailingAnchor, Constants.ParametersView.parameterWrapOffsetH)
        
        configureImage()
        configureLabel()
    }
    
    private func configureImage() {
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(systemName: "questionmark")
        icon.tintColor = .label
        
        wrap.addSubview(icon)
        
        icon.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        icon.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        icon.pinLeft(to: wrap.leadingAnchor, Constants.ParametersView.iconLeftOffset)
        icon.setWidth(Constants.ParametersView.iconWidth)
    }
    
    private func configureLabel() {
        parametersLabel.textColor = .black
        parametersLabel.textAlignment = .left
        parametersLabel.font = .systemFont(ofSize: Constants.ParametersView.parametersLabelFontSize, weight: .medium)
        parametersLabel.text = "Error"
        
        wrap.addSubview(parametersLabel)
        
        parametersLabel.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        parametersLabel.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        parametersLabel.pinLeft(to: icon.trailingAnchor, Constants.ParametersView.parametersLabelLeftOffset)
        parametersLabel.pinRight(to: wrap.trailingAnchor, Constants.ParametersView.parametersLabelRightOffset)
    }
    
    // MARK: - Public functions
    public func configure(with image: UIImage, and label: String) {
        self.icon.image = image
        self.parametersLabel.text = label
    }
}
