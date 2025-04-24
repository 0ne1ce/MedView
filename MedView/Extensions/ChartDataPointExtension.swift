//
//  ChartDataPointExtension.swift
//  MedView
//
//  Created by Алексей on 25.04.2025.
//
import Foundation

extension ChartDataPoint: CustomStringConvertible {
    var description: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "(\(formatter.string(from: date)), value: \(value))"
    }
}
