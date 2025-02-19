//
//  AddParamterCell.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AddParamterCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let plusWrapRadius: CGFloat = 7
        static let plusWrapOffsetV: CGFloat = 8
        static let plusWrapWidth: CGFloat = 44
        
        static let parameterWrapOffsetH: CGFloat = 15
        
        static let parametersLabelFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        
        static let addLabelText: String = "Create custom parameter"
        
        static let addLabelLeftOffset: CGFloat = 17
        static let addLabelRightOffset: CGFloat = 20
    }
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
        plusWrap.layer.cornerRadius = Constants.plusWrapRadius
        
        contentView.addSubview(plusWrap)
        
        plusWrap.pinTop(to: self.contentView.topAnchor, Constants.plusWrapOffsetV)
        plusWrap.pinBottom(to: self.contentView.bottomAnchor, Constants.plusWrapOffsetV)
        plusWrap.pinLeft(to: self.contentView.leadingAnchor, Constants.parameterWrapOffsetH)
        plusWrap.setWidth(Constants.plusWrapWidth)
    }
    
    private func configureImage() {
        plusIcon.contentMode = .scaleAspectFill
        plusIcon.image = UIImage(named: "PlusSymbol")
        plusIcon.tintColor = .label
        
        plusWrap.addSubview(plusIcon)

        plusIcon.pinCenter(to: plusWrap)
    }
    
    private func configureLabel() {
        addLabel.text = Constants.addLabelText
        addLabel.textColor = .black
        addLabel.font = Constants.parametersLabelFont
        addLabel.textAlignment = .left
        
        contentView.addSubview(addLabel)
        addLabel.pinTop(to: contentView.layoutMarginsGuide.topAnchor)
        addLabel.pinBottom(to: contentView.layoutMarginsGuide.bottomAnchor)
        addLabel.pinLeft(to: plusWrap.trailingAnchor, Constants.addLabelLeftOffset)
        addLabel.pinRight(to: contentView.trailingAnchor, Constants.addLabelRightOffset)
    }
}
