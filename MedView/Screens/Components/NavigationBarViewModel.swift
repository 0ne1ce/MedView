//
//  ParametersNavigationBarViewModel.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//
import Foundation
import UIKit

final class NavigationBarViewModel: CustomNavigationBarViewModel {
    // MARK: - Properties
    var attributedTitle: NSMutableAttributedString?
    var title: String?
    var backgroundColor: UIColor
    var isSettingsButtonHidden: Bool
    
    init(attributedTitle: NSMutableAttributedString? = nil, title: String? = nil, isSettingsButtonHidden: Bool) {
        self.attributedTitle = attributedTitle
        self.title = title
        self.backgroundColor = .white
        self.isSettingsButtonHidden = isSettingsButtonHidden
    }
}
