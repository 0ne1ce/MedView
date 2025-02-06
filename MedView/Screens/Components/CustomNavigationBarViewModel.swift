//
//  CustomNavigationBar.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//
import Foundation
import UIKit

protocol CustomNavigationBarViewModel {
    // MARK: - Properties
    var attributedTitle: NSMutableAttributedString? { get }
    var title: String? { get }
    var backgroundColor: UIColor { get }
    var isSettingsButtonHidden: Bool { get }
}
