//
//  ParametersModels.swift
//  MedView
//
//  Created by Алексей on 11.02.2025.
//

import Foundation
import UIKit

enum ParametersModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleText: NSMutableAttributedString
            var tableTitleText: String
            var settingsImageName: String
        }
        
        struct ViewModel {
            var titleText: NSMutableAttributedString
            var tableBackgroundColor: UIColor
            var tableTitleText: String
            var tableTitleColor: UIColor
            var tableTitleFont: UIFont
            var navigationTitleFont: UIFont
            var settingsImage: UIImage?
            var navigationBackgroundColor: UIColor
            var borderlineColor: UIColor
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
