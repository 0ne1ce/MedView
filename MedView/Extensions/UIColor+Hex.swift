//
//  UIColor+hexToRGB.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//
import Foundation
import UIKit

// MARK: - UIColor
extension UIColor {
    //MARK: - Variables
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    //MARK: - Functions
    func hexToRGB(hex: String) -> UIColor {
        let formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb : UInt64 = 0
        Scanner (string: formattedHex).scanHexInt64(&rgb)
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgb & 0x0000FF) / 255.0,
                       alpha: 1)
    }
}
