//
//  HelpModels.swift
//  MedView
//
//  Created by Алексей on 22.02.2025.
//

import Foundation
import UIKit

enum HelpModels {
    enum LoadStart {
        struct Request {
            
        }
            
        struct Response {
            var titleText: NSMutableAttributedString
            var settingsImageName: String
            var animationName: String
        }
            
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var navigationBackgroundColor: UIColor
            var borderlineColor: UIColor
            var animationName: String
        }
    }
        
    enum LoadSettings {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
