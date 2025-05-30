//
//  MedParameterRouterProtocol.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

protocol MedParameterRouterProtocol: AnyObject {
    // MARK: - Functions
    func showSettingsScreen()
    func showAssistant(with data: [ChartDataPoint], and parameterName: String)
}
