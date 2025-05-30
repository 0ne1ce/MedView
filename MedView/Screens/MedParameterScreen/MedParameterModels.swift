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
            var placeholderText: String
            var awaitText: String
            var settingsImageName: String
            var deleteButtonText: String
            var parameter: MedParameter
            var adviceButtonText: String
            var data: [MedParameterData]
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
            var awaitText: String
            var awaitTitleFont: UIFont
            var deleteButtonText: String
            var deleteButtonFont: UIFont
            var parameterColor: UIColor
            var adviceButtonText: String
            var adviceButtonColor: UIColor
            var adviceButtonTextColor: UIColor
            var adviceButtonFont: UIFont
            var data: [ChartDataPoint]
        }
    }
    
    enum SaveValue {
        struct Request {
            var value: String
        }
        
        struct Response {
            var parameter: MedParameter
            var data: [MedParameterData]
        }
        
        struct ViewModel {
            var parameterColor: UIColor
            var data: [ChartDataPoint]
        }
    }
    
    enum DeleteData {
        struct Request {

        }
        
        struct Response {
            var data: [MedParameterData]
        }
        
        struct ViewModel {
            var data: [ChartDataPoint]
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
    
    enum LoadAssistantAdvice {
        struct Request {
            
        }
        
        struct Response {
            var parameterName: String
            var data: [MedParameterData]
        }
        
        struct ViewModel {
            var parameterName: String
            var data: [ChartDataPoint]
        }
    }
}
