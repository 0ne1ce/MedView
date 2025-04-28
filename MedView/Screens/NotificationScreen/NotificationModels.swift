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
            var type: NotificationType
            var tableTitleText: String
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var type: NotificationType
            var tableTitleText: String
            var tableTitleColor: UIColor
            var tableTitleFont: UIFont
            var tableBackgroundColor: UIColor
        }
    }
    
    enum LoadAddTimeScreen {
        struct Request {
            var index: Int?
        }
        
        struct Response {
            var timestamp: TimestampData?
        }
        
        struct ViewModel {
            var timestamp: Timestamp?
        }
    }
    
    enum AddTimestamp {
        struct Request {
            var currentTimestamp: Timestamp?
            var timestamp: Timestamp
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum DeleteTimestamp {
        struct Request {
            var index: Int
        }
        
        struct Response {
            var index: Int
        }
        
        struct ViewModel {
            var index: Int
        }
    }
}
