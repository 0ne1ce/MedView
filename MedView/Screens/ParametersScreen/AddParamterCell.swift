//
//  AddParamterCell.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AddParamterCell: UITableViewCell {
    // MARK: - Variables
    static let id: String = "AddParameterCell"
    private let plusWrap: UIView = UIView()
    private let plusIcon: UIImageView = UIImageView()
    private let addLabel: UILabel = UILabel()
    
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
        plusWrap.backgroundColor = .white
        plusWrap.layer.cornerRadius = ParametersConstants.plusWrapRadius
        
        contentView.addSubview(plusWrap)
        
        plusWrap.pinTop(to: self.contentView.topAnchor, ParametersConstants.plusWrapOffsetV)
        plusWrap.pinBottom(to: self.contentView.bottomAnchor, ParametersConstants.plusWrapOffsetV)
        plusWrap.pinLeft(to: self.contentView.leadingAnchor, ParametersConstants.parameterWrapOffsetH)
        plusWrap.setWidth(ParametersConstants.plusWrapWidth)
    }
    
    private func configureImage() {
        plusIcon.contentMode = .scaleAspectFill
        plusIcon.image = UIImage(named: "PlusSymbol")
        plusIcon.tintColor = .label
        
        plusWrap.addSubview(plusIcon)

        plusIcon.pinCenter(to: plusWrap)
    }
    
    private func configureLabel() {
        addLabel.text = ParametersConstants.addLabelText
        addLabel.textColor = .black
        addLabel.font = .systemFont(ofSize: ParametersConstants.parametersLabelFontSize, weight: .medium)
        addLabel.textAlignment = .left
        
        contentView.addSubview(addLabel)
        addLabel.pinTop(to: contentView.layoutMarginsGuide.topAnchor)
        addLabel.pinBottom(to: contentView.layoutMarginsGuide.bottomAnchor)
        addLabel.pinLeft(to: plusWrap.trailingAnchor, ParametersConstants.addLabelLeftOffset)
        addLabel.pinRight(to: contentView.trailingAnchor, ParametersConstants.addLabelRightOffset)
    }
}
