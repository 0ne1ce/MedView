//
//  NavigationTitleRepresentable.swift
//  MedView
//
//  Created by Алексей on 19.02.2025.
//
import Foundation
import UIKit

protocol NavigationTitleRepresentable {
    var navigationTitle: NSMutableAttributedString { get }
    var navigationTitleFont: UIFont { get }
    var navigationTitleColor: UIColor? { get }
    var settingsImage: UIImage? { get }
    var navigationBackgroundColor: UIColor { get }
    var borderlineColor: UIColor { get }
}
