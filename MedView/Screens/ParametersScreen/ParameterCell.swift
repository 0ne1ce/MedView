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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        wrap.backgroundColor = .white
        wrap.layer.cornerRadius = ParametersConstants.parameterWrapRadius
        
        wrap.pinTop(to: contentView, ParametersConstants.parameterWrapOffsetV)
        wrap.pinBottom(to: contentView, ParametersConstants.parameterWrapOffsetV)
        wrap.pinLeft(to: contentView, ParametersConstants.parameterWrapOffsetH)
        wrap.pinRight(to: contentView, ParametersConstants.parameterWrapOffsetH)
    }
    
    private func configureImage() {
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(systemName: "questionmark")
        icon.tintColor = .label
        
        wrap.addSubview(icon)
        
        icon.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        icon.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        icon.pinLeft(to: wrap, ParametersConstants.iconLeftOffset)
        icon.setWidth(ParametersConstants.iconWidth)
    }
    
    private func configureLabel() {
        parametersLabel.textColor = .black
        parametersLabel.textAlignment = .left
        parametersLabel.font = .systemFont(ofSize: ParametersConstants.parametersLabelFontSize, weight: .medium)
        parametersLabel.text = "Error"
        
        wrap.addSubview(parametersLabel)
        
        parametersLabel.pinTop(to: wrap.layoutMarginsGuide.topAnchor)
        parametersLabel.pinBottom(to: wrap.layoutMarginsGuide.bottomAnchor)
        parametersLabel.pinLeft(to: icon.trailingAnchor, ParametersConstants.parametersLabelLeftOffset)
        parametersLabel.pinRight(to: wrap, ParametersConstants.parametersLabelRightOffset)
    }
    
    // MARK: - Public functions
    public func configure(with image: UIImage, and label: String) {
        self.icon.image = image
        self.parametersLabel.text = label
    }
}
