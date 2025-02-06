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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = .clear
        configureWrap()
        configureImage()
        configureLabel()
    }
    
    private func configureWrap() {
        plusWrap.backgroundColor = .white
        plusWrap.layer.cornerRadius = Constants.ParametersView.plusWrapRadius
        
        contentView.addSubview(plusWrap)
        
        plusWrap.pinTop(to: self.contentView.topAnchor, Constants.ParametersView.plusWrapOffsetV)
        plusWrap.pinBottom(to: self.contentView.bottomAnchor, Constants.ParametersView.plusWrapOffsetV)
        plusWrap.pinLeft(to: self.contentView.leadingAnchor, Constants.ParametersView.parameterWrapOffsetH)
        plusWrap.setWidth(Constants.ParametersView.plusWrapWidth)
    }
    
    private func configureImage() {
        plusIcon.contentMode = .scaleAspectFill
        plusIcon.image = UIImage(named: "PlusSymbol")
        plusIcon.tintColor = .label
        
        plusWrap.addSubview(plusIcon)

        plusIcon.pinCenter(to: plusWrap)
    }
    
    private func configureLabel() {
        addLabel.text = Constants.ParametersView.addLabelText
        addLabel.textColor = .label
        addLabel.font = .systemFont(ofSize: Constants.ParametersView.parametersLabelFontSize, weight: .medium)
        addLabel.textAlignment = .left
        
        contentView.addSubview(addLabel)
        addLabel.pinTop(to: contentView.layoutMarginsGuide.topAnchor)
        addLabel.pinBottom(to: contentView.layoutMarginsGuide.bottomAnchor)
        addLabel.pinLeft(to: plusWrap.trailingAnchor, Constants.ParametersView.addLabelLeftOffset)
        addLabel.pinRight(to: contentView.trailingAnchor, Constants.ParametersView.addLabelRightOffset)
    }
}
