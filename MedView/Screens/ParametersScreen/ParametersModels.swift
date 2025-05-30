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
        
        struct ViewModel: NavigationTitleRepresentable {
            var navigationTitle: NSMutableAttributedString
            var tableBackgroundColor: UIColor
            var tableTitleText: String
            var tableTitleColor: UIColor
            var tableTitleFont: UIFont
            var navigationTitleFont: UIFont
            var navigationTitleColor: UIColor?
            var settingsImage: UIImage?
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
    
    enum LoadParameter {
        struct Request {
            var id: Int
            var parameterTitle: String
        }
        
        struct Response {
            var id: Int
            var parameterType: MedParameterType
        }
        
        struct ViewModel {
            var parameter: MedParameter
        }
    }
    
    enum FirstLaunch {
        struct Request {

        }
        
        struct Response {

        }
        
        struct ViewModel {
            
        }
    }
}
