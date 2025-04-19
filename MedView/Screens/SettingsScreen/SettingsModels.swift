//
//  SettingsModels.swift
//  MedView
//
//  Created by Алексей on 23.02.2025.
//

import Foundation
import UIKit

enum SettingsModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleText: NSMutableAttributedString
            var buttonTitle: String
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var buttonTitle: String
            var buttonTitleFont: UIFont
            var buttonTitleColor: UIColor
            var buttonColor: UIColor
            var buttonImageTintColor: UIColor
            var buttonImage: UIImage?
        }
    }
    
    enum LoadAboutDev {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum LoadCard {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum LoadNotification {
        struct Request {
            var notificationTitle: String
        }
        
        struct Response {
            var notificationTitle: String
            var isCustomType: Bool
        }
        
        struct ViewModel {
            var notification: Notification
        }
    }
    
    enum AddCustomNotification {
        struct Request {

        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum DeleteCustomNotification {
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
