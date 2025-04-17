//
//  ChartView.swift
//  MedView
//
//  Created by Алексей on 16.04.2025.
//

import SwiftUI
import Charts

struct ChartView: View {
    let data: [ChartDataPoint]
    let color: Color
    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(color)
            .lineStyle(StrokeStyle(lineWidth: 3))
            .symbol(Circle())
            
            AreaMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(Gradient(colors: [color.opacity(0.35), .clear]))
        }
        .background(.backgroundPrimary)
        .chartYAxis {
            AxisMarks(position: .leading)
        }
    }
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
