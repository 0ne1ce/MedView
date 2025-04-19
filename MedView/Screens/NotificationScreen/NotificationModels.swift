//
//  SettingsModels.swift
//  MedView
//
//  Created by Алексей on 23.02.2025.
//

import Foundation
import UIKit

enum NotificationModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleText: NSMutableAttributedString
            var customType: Bool
            var tableTitleText: String
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var customType: Bool
            var tableTitleText: String
            var tableTitleColor: UIColor
            var tableTitleFont: UIFont
            var tableBackgroundColor: UIColor
        }
    }
    
    enum LoadAddTimeScreen {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
