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
            var navigationBackgroundColor: UIColor
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
}
