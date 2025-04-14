//
//  SettingsModels.swift
//  MedView
//
//  Created by Алексей on 23.02.2025.
//

import Foundation
import UIKit

enum CardModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleText: NSMutableAttributedString
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var navigationBackgroundColor: UIColor
        }
    }
}
