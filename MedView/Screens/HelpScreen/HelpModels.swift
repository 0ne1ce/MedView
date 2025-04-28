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
            var onboardingButtonText: String
        }
            
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var animationName: String
            var tableBackgroundColor: UIColor
            var onboardingButtonColor: UIColor
            var onboardingButtonBoundsColor: UIColor
            var onboardingButtonText: String
            var onboardingButtonTextColor: UIColor
            var onboardingButtonTextFont: UIFont
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
    
    enum LoadOnboarding {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
