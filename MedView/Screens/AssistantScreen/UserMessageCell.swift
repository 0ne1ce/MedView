//
//  UserMessageCell.swift
//  MedView
//
//  Created by Алексей on 27.02.2025.
//

import Foundation
import UIKit

final class UserMessageCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let messageBubbleOffsetTop: CGFloat = 10
        static let messageBubbleOffsetLeft: CGFloat = 100
        static let messageBubbleOffsetRight: CGFloat = 15
        static let messageBubbleCornerRadius: CGFloat = 15
        
        static let sendButtonColorHex: String = "00C7C0"
        
        static let messageTextViewOffsetH: CGFloat = 10
        static let messageTextViewFont: UIFont = UIFont.systemFont(ofSize: 18)
    }
    
    // MARK: - Properties
    static let reuseId: String = "UserMessage"
    
    // MARK: - Variables
    var messageBubble: UIView = UIView()
    var messageTextView: UITextView = UITextView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public funtions
    func configure(with message: String) {
        messageTextView.text = message
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
        messageBubble.backgroundColor = UIColor(hex: Constants.sendButtonColorHex)
    }
    
    private func configureWrapTextLabel() {
        messageBubble.addSubview(messageTextView)
        messageTextView.pinHorizontal(to: messageBubble, Constants.messageTextViewOffsetH)
        messageTextView.pinVertical(to: messageBubble)
        
        messageTextView.backgroundColor = UIColor(hex: Constants.sendButtonColorHex)
        messageTextView.layer.cornerRadius = Constants.messageBubbleCornerRadius
        messageTextView.textColor = .white
        messageTextView.font = Constants.messageTextViewFont
        messageTextView.textAlignment = .left
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.isSelectable = true
    }
}
