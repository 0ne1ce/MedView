//
//  AssistantMessageCell.swift
//  MedView
//
//  Created by Алексей on 27.02.2025.
//

import Foundation
import UIKit

final class AssistantMessageCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let messageBubbleOffsetTop: CGFloat = 10
        static let messageBubbleOffsetLeft: CGFloat = 15
        static let messageBubbleOffsetRight: CGFloat = 100
        static let messageBubbleCornerRadius: CGFloat = 15
        
        static let sendButtonColorHex: String = "00C7C0"
        
        static let messageTextLabelOffsetH: CGFloat = 10
        static let messageTextLabelOffsetV: CGFloat = 7
        static let messageTextLabelFont: UIFont = UIFont.systemFont(ofSize: 18)
    }
    
    // MARK: - Properties
    static let reuseId: String = "AssistantMessage"
    
    // MARK: - Variables
    var messageBubble: UIView = UIView()
    var messageTextLabel: UILabel = UILabel()
    
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
    func configure(with message: String) {
        messageTextLabel.text = message
    }
    
    // MARK: - Private functions
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        configureWrap()
        configureWrapTextLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(messageBubble)
        messageBubble.pinCenter(to: contentView)
        messageBubble.pinTop(to: contentView, Constants.messageBubbleOffsetTop)
        messageBubble.pinLeft(to: contentView, Constants.messageBubbleOffsetLeft)
        messageBubble.pinRight(to: contentView, Constants.messageBubbleOffsetRight)
        
        messageBubble.layer.cornerRadius = Constants.messageBubbleCornerRadius
        messageBubble.backgroundColor = .white
    }
    
    private func configureWrapTextLabel() {
        messageBubble.addSubview(messageTextLabel)
        messageTextLabel.pinHorizontal(to: messageBubble, Constants.messageTextLabelOffsetH)
        messageTextLabel.pinVertical(to: messageBubble, Constants.messageTextLabelOffsetV)
        
        messageTextLabel.textColor = .black
        messageTextLabel.font = Constants.messageTextLabelFont
        messageTextLabel.textAlignment = .left
        messageTextLabel.numberOfLines = .zero
    }
}
