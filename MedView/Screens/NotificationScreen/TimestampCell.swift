//
//  TimestampCell.swift
//  MedView
//
//  Created by Алексей on 19.04.2025.
//
import UIKit

final class TimestampCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let timestampWrapRadius: CGFloat = 10
        static let timestampWrapOffsetV: CGFloat = 5
        static let timestampWrapOffsetH: CGFloat = 15
        
        static let timeLabelOffsetLeft: CGFloat = 15
        static let timeLabelOffsetTop: CGFloat = 5
        static let timeLabelFont: UIFont = .systemFont(ofSize: 45, weight: .light)
        static let timeLabelHeight: CGFloat = 47
        
        static let subtitleLabelFont: UIFont = .systemFont(ofSize: 16)
        static let subtitleLabelHeight: CGFloat = 18
        
        static let statusLabelOffsetLeft: CGFloat = 3
        
        static let arrowOffsetRight: CGFloat = 10
        static let arrowOffsetV: CGFloat = 25
        static let arrowOffsetWidth: CGFloat = 25
    }
    
    // MARK: - Properties
    private let wrap: UIView = UIView()
    private let timeLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    private let statusLabel: UILabel = UILabel()
    private let arrowImageView: UIImageView = UIImageView()
    
    static let reuseId: String = "TimestampCell"
    
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
    func configure(timestamp: Timestamp) {
        timeLabel.text = timestamp.time
        statusLabel.text = timestamp.repeatStatus ? "On" : "Off"
        statusLabel.textColor = timestamp.repeatStatus ? .systemGreen : .systemOrange
    }
    
    // MARK: - Privtae functions
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        configureWrap()
        configureTimeLabel()
        configureSubtitle()
        configureStatusLabel()
        configureArrow()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        wrap.backgroundColor = UIColor.cellBackground
        wrap.layer.cornerRadius = Constants.timestampWrapRadius
        
        wrap.pinVertical(to: contentView, Constants.timestampWrapOffsetV)
        wrap.pinHorizontal(to: contentView, Constants.timestampWrapOffsetH)
    }
    
    private func configureTimeLabel() {
        wrap.addSubview(timeLabel)
        timeLabel.pinLeft(to: wrap.leadingAnchor, Constants.timeLabelOffsetLeft)
        timeLabel.pinTop(to: wrap.topAnchor, Constants.timeLabelOffsetTop)
        timeLabel.setHeight(Constants.timeLabelHeight)
        
        timeLabel.font = Constants.timeLabelFont
        timeLabel.textColor = .label
        timeLabel.textAlignment = .left
    }
    
    private func configureSubtitle() {
        wrap.addSubview(subtitleLabel)
        subtitleLabel.pinLeft(to: timeLabel.leadingAnchor)
        subtitleLabel.pinTop(to: timeLabel.bottomAnchor)
        subtitleLabel.setHeight(Constants.subtitleLabelHeight)
        
        subtitleLabel.font = Constants.subtitleLabelFont
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.text = "Repeat:"
        subtitleLabel.textAlignment = .left
    } 
    
    private func configureStatusLabel() {
        wrap.addSubview(statusLabel)
        statusLabel.pinLeft(to: subtitleLabel.trailingAnchor, Constants.statusLabelOffsetLeft)
        statusLabel.pinTop(to: timeLabel.bottomAnchor)
        statusLabel.setHeight(Constants.subtitleLabelHeight)
        
        statusLabel.font = Constants.subtitleLabelFont
        statusLabel.textColor = .secondaryLabel
        statusLabel.textAlignment = .left
    }
    
    private func configureArrow() {
        wrap.addSubview(arrowImageView)
        arrowImageView.pinRight(to: wrap.trailingAnchor, Constants.arrowOffsetRight)
        arrowImageView.pinVertical(to: wrap, Constants.arrowOffsetV)
        arrowImageView.setWidth(Constants.arrowOffsetWidth)
        
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .lightGray
    }
}
