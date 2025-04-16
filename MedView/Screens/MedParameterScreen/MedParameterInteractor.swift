//
//  MedParameterInteractor.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//
import UIKit
import Foundation

final class MedParameterInteractor: MedParameterBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Properties
    var presenter: MedParameterPresentationLogic
    var worker: MedParameterWorker
    
    private var chartDataPoints: [ChartDataPoint] = []
    
    // MARK: - Initialization
    init(presenter: MedParameterPresentationLogic, worker: MedParameterWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: MedParameterModels.LoadStart.Request) {
        let response = MedParameterModels.LoadStart.Response()
        presenter.presentStart(response: response)
    }
    
    func saveTextFieldValue(request: MedParameterModels.SaveValue.Request) {
        guard let value = Double(request.value) else {
            return
        }
        let newPoint = ChartDataPoint(date: Date(), value: value)
        chartDataPoints.append(newPoint)
        let response = MedParameterModels.SaveValue.Response(data: chartDataPoints)
        presenter.presentTextFieldValue(response: response)
    }
}
