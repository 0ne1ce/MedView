//
//  MedParameterModels.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import UIKit
import Foundation

enum MedParameterModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel: NavigationTitleRepresentable {
            var backgroundColor: UIColor
            var navigationTitle: NSMutableAttributedString
            var settingsImage: UIImage?
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var textFont: UIFont
            var inputWrapBackgroundColor: UIColor
            var placeholderText: String
            var placeholderFont: UIFont
            var placeholderColor: UIColor
            var sendButtonColor: UIColor
            var sendButtonTintColor: UIColor
        }
    }
    
    enum SaveValue {
        struct Request {
            var value: String
        }
        
        struct Response {
            var data: [ChartDataPoint]
        }
        
        struct ViewModel {
            var data: [ChartDataPoint]
        }
    }
}
