//
//  MedParameterPresenter.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import UIKit
import Foundation

final class MedParameterPresenter: MedParameterPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationTitleFont: UIFont = UIFont.systemFont(ofSize: 36).bold
        static let textFont: UIFont = .systemFont(ofSize: 20)
        
        static let placeholderFont: UIFont = UIFont.systemFont(ofSize: 18).bold
        
        static let awaitFont: UIFont = UIFont.systemFont(ofSize: 24).bold
        
        static let deleteButtonFont: UIFont = UIFont.systemFont(ofSize: 18)
        
        static let adviceButtonFont: UIFont = .systemFont(ofSize: 18)
    }
    
    // MARK: - Properties
    weak var view: MedParameterDisplayLogic?
    
    // MARK: - Public functions
    func presentStart(response: MedParameterModels.LoadStart.Response) {
        let dataChartPoints: [ChartDataPoint] = response.data.map {
            ChartDataPoint(date: $0.timeStamp, value: Double($0.numericValue))
        }
        let navigationParameterTitle = NSMutableAttributedString(string: response.parameter.type.rawValue)
        
        let viewModel = MedParameterModels.LoadStart.ViewModel(
            backgroundColor: .backgroundPrimary,
            navigationTitle: navigationParameterTitle,
            settingsImage: UIImage(named: response.settingsImageName),
            navigationTitleFont: Constants.navigationTitleFont,
            textFont: Constants.textFont,
            inputWrapBackgroundColor: UIColor.cellBackground,
            placeholderText: response.placeholderText,
            placeholderFont: Constants.placeholderFont,
            placeholderColor: .lightGray,
            sendButtonColor: response.parameter.color,
            sendButtonTintColor: .white,
            awaitText: response.awaitText,
            awaitTitleFont: Constants.awaitFont,
            deleteButtonText: response.deleteButtonText,
            deleteButtonFont: Constants.deleteButtonFont,
            parameterColor: response.parameter.color,
            adviceButtonText: response.adviceButtonText,
            adviceButtonColor: response.parameter.color,
            adviceButtonTextColor: .white,
            adviceButtonFont: Constants.adviceButtonFont,
            data: dataChartPoints
        )
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentTextFieldValue(response: MedParameterModels.SaveValue.Response) {
        let viewModel = MedParameterModels.SaveValue.ViewModel(
            parameterColor: response.parameter.color,
            data: dataToChartPoints(data: response.data)
        )
        view?.displayTextFieldValue(viewModel: viewModel)
    }
    
    func presentAfterDeletion(response: MedParameterModels.DeleteData.Response) {
        let viewModel = MedParameterModels.DeleteData.ViewModel(data: dataToChartPoints(data: response.data))
        view?.displayAferDeletion(viewModel: viewModel)
    }
    
    func presentSettings(response: MedParameterModels.LoadSettings.Response) {
        let viewModel = MedParameterModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
    
    func presentAssistantAdvice(response: MedParameterModels.LoadAssistantAdvice.Response) {
        let viewModel = MedParameterModels.LoadAssistantAdvice.ViewModel(
            parameterName: response.parameterName,
            data: dataToChartPoints(data: response.data)
        )
        view?.displayAssistantAdvice(viewModel: viewModel)
    }
    
    // MARK: - Private functions
    private func dataToChartPoints(data: [MedParameterData]) -> [ChartDataPoint] {
        let dataChartPoints: [ChartDataPoint] = data.map {
            ChartDataPoint(date: $0.timeStamp, value: Double($0.numericValue))
        }
        
        return dataChartPoints
    }
}
