//
//  PaarametersConstants.swift
//  MedView
//
//  Created by Алексей on 02.02.2025.
//

import Foundation
import UIKit

enum Constants {
    static let backgroundLightHex: String = "F2F2F7"
    
    enum CustomNavigationBarView {
        static let navigationBarHeight: CGFloat = 120
        static let navigationBarBorderlineHeight: CGFloat = 1
        static let titleLabelFontSize: CGFloat = 40
        static let settingsButtonSize: CGFloat = 40
        static let navigationBarItemOffset: CGFloat = 20
        
        static let settingsSymbol: String = "SettingsSymbol"
    }
    
    enum ParametersView {
        static let medViewLabelText: String = "MedView"
        
        static let systemColorStringLocation: Int = 0
        static let systemColorStringLength: Int = 3
        static let mintColorStringLocation: Int = 3
        static let mintColorStringLength: Int = 4
        
        static let tableViewTopOffset: CGFloat = 175
        static let heightForRow: CGFloat = 60
        
        static let parameterWrapRadius: CGFloat = 10
        static let parameterWrapOffsetV: CGFloat = 5
        static let parameterWrapOffsetH: CGFloat = 15
        
        static let iconLeftOffset: CGFloat = 15
        static let iconWidth: CGFloat = 20
        
        static let parametersLabelFontSize: CGFloat = 20
        static let parametersLabelLeftOffset: CGFloat = 25
        static let parametersLabelRightOffset: CGFloat = 5
        
        static let plusWrapRadius: CGFloat = 7
        static let plusWrapOffsetV: CGFloat = 8
        static let plusWrapWidth: CGFloat = 44
        
        static let addLabelText: String = "Create custom parameter"
        static let addLabelLeftOffset: CGFloat = 17
        static let addLabelRightOffset: CGFloat = 20
        static let AddParamterCellCount: Int = 1
    }
    
    enum ParametersPictures {
        static let bloodPressure: String = "Blood pressure"
        static let pulse: String = "Pulse"
        static let saturation: String = "Saturation"
        static let sleepHours: String = "Sleep hours"
        static let stressLevel: String = "Stress level"
        static let temperature: String = "Temperature"
        static let weight: String = "Weight"
        static let bloodGlucose: String = "Blood glucose"
        static let customParameter: String = "Custom parameter"
    }
}
