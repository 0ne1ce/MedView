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
        static let placeholderText: String = "Value"
        static let awaitText: String = "There is no data yet..."
        static let settingsImageName: String = "SettingsSymbol"
        static let deleteButtonText: String = "Clear"
    }
    
    // MARK: - Properties
    var presenter: MedParameterPresentationLogic
    var worker: MedParameterWorker
    var medParameter: MedParameter
    
    private var pulseDataPoints: [Pulse] = []
    
    // MARK: - Initialization
    init(presenter: MedParameterPresentationLogic, worker: MedParameterWorker, medParameter: MedParameter) {
        self.presenter = presenter
        self.worker = worker
        self.medParameter = medParameter
    }
    
    // MARK: - Public functions
    func loadStart(request: MedParameterModels.LoadStart.Request) {
        pulseDataPoints = worker.loadPulse()
        let response = MedParameterModels.LoadStart.Response(
            placeholderText: Constants.placeholderText,
            awaitText: Constants.awaitText,
            settingsImageName: Constants.settingsImageName,
            deleteButtonText: Constants.deleteButtonText,
            parameter: medParameter,
            data: pulseDataPoints
        )
        presenter.presentStart(response: response)
    }
    
    func saveTextFieldValue(request: MedParameterModels.SaveValue.Request) {
        guard let value = Double(request.value) else {
            return
        }
        let currentDate = Date()
        worker.savePulse(value: value, date: currentDate)
        pulseDataPoints = worker.loadPulse()
        let response = MedParameterModels.SaveValue.Response(parameter: medParameter, data: pulseDataPoints)
        presenter.presentTextFieldValue(response: response)
    }
    
    func deleteData(request: MedParameterModels.DeleteData.Request) {
        worker.deletePulseData()
        pulseDataPoints = worker.loadPulse()
        let response = MedParameterModels.DeleteData.Response(data: pulseDataPoints)
        presenter.presentAfterDeletion(response: response)
    }
    
    func loadSettings(request: MedParameterModels.LoadSettings.Request) {
        let response = MedParameterModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
}
