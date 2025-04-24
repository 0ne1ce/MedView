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
        static let adviceButtonText: String = "Get advice"
    }
    
    // MARK: - Properties
    var presenter: MedParameterPresentationLogic
    var worker: MedParameterWorker
    var medParameter: MedParameter
    
    private var data: [MedParameterData] = []
    
    // MARK: - Initialization
    init(presenter: MedParameterPresentationLogic, worker: MedParameterWorker, medParameter: MedParameter) {
        self.presenter = presenter
        self.worker = worker
        self.medParameter = medParameter
    }
    
    // MARK: - Public functions
    func loadStart(request: MedParameterModels.LoadStart.Request) {
        loadParameterData()
        let response = MedParameterModels.LoadStart.Response(
            placeholderText: Constants.placeholderText,
            awaitText: Constants.awaitText,
            settingsImageName: Constants.settingsImageName,
            deleteButtonText: Constants.deleteButtonText,
            parameter: medParameter,
            adviceButtonText: Constants.adviceButtonText,
            data: data
        )
        presenter.presentStart(response: response)
    }
    
    func saveTextFieldValue(request: MedParameterModels.SaveValue.Request) {
        guard let value = Double(request.value) else {
            return
        }
        let currentDate = Date()
        saveParameterData(value: value, currentDate: currentDate)
        loadParameterData()
        let response = MedParameterModels.SaveValue.Response(parameter: medParameter, data: data)
        presenter.presentTextFieldValue(response: response)
    }
    
    func deleteData(request: MedParameterModels.DeleteData.Request) {
        deleteParameterData()
        loadParameterData()
        let response = MedParameterModels.DeleteData.Response(data: data)
        presenter.presentAfterDeletion(response: response)
    }
    
    func loadSettings(request: MedParameterModels.LoadSettings.Request) {
        let response = MedParameterModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
    
    func loadAssistantAdvice(request: MedParameterModels.LoadAssistantAdvice.Request) {
        let response = MedParameterModels.LoadAssistantAdvice.Response(
            parameterName: medParameter.type.rawValue,
            data: data
        )
        presenter.presentAssistantAdvice(response: response)
    }
    
    // MARK: - Private functions
    private func loadParameterData() {
        switch medParameter.id {
        case 0:
            data = worker.loadParameterData(type: StepActivity.self)
        case 1:
            data = worker.loadParameterData(type: Pulse.self)
        case 2:
            data = worker.loadParameterData(type: Saturation.self)
        case 3:
            data = worker.loadParameterData(type: SleepHours.self)
        case 4:
            data = worker.loadParameterData(type: StressLevel.self)
        case 5:
            data = worker.loadParameterData(type: Temperature.self)
        case 6:
            data = worker.loadParameterData(type: Weight.self)
        case 7:
            data = worker.loadParameterData(type: BloodGlucose.self)
        default:
            break
        }
    }
    
    private func saveParameterData(value: Double, currentDate: Date) {
        switch medParameter.id {
        case 0:
            worker.saveParameterData(type: StepActivity.self, value: value, date: currentDate)
        case 1:
            worker.saveParameterData(type: Pulse.self, value: value, date: currentDate)
        case 2:
            worker.saveParameterData(type: Saturation.self, value: value, date: currentDate)
        case 3:
            worker.saveParameterData(type: SleepHours.self, value: value, date: currentDate)
        case 4:
            worker.saveParameterData(type: StressLevel.self, value: value, date: currentDate)
        case 5:
            worker.saveParameterData(type: Temperature.self, value: value, date: currentDate)
        case 6:
            worker.saveParameterData(type: Weight.self, value: value, date: currentDate)
        case 7:
            worker.saveParameterData(type: BloodGlucose.self, value: value, date: currentDate)
        default:
            break
        }
    }
    
    private func deleteParameterData() {
        switch medParameter.id {
        case 0:
            worker.deleteParameterData(type: StepActivity.self)
        case 1:
            worker.deleteParameterData(type: Pulse.self)
        case 2:
            worker.deleteParameterData(type: Saturation.self)
        case 3:
            worker.deleteParameterData(type: SleepHours.self)
        case 4:
            worker.deleteParameterData(type: StressLevel.self)
        case 5:
            worker.deleteParameterData(type: Temperature.self)
        case 6:
            worker.deleteParameterData(type: Weight.self)
        case 7:
            worker.deleteParameterData(type: BloodGlucose.self)
        default:
            break
        }
    }
}
