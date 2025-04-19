//
//  ParametersInteractor.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersInteractor: NSObject, ParametersBuisnessLogic {    
    // MARK: - Constants
    private enum Constants {
        static let medViewLabelText: String = "MedView"
        static let tableTitleText: String = "Your health parameters"
        static let settingsImageName: String = "SettingsSymbol"
        
        static let mainColor: UIColor = UIColor.main
        
        static let systemColorStringLocation: Int = 0
        static let systemColorStringLength: Int = 3
        static let mintColorStringLocation: Int = 3
        static let mintColorStringLength: Int = 4
        
        static let numberOfSections: Int = 2
        static let parameterCellCount: Int = 8
        static let addParamterCellCount: Int = 1
    }
    
    // MARK: - Properties
    var presenter: ParametersPresentationLogic
    var worker: ParametersWorker
    
    // MARK: - Initialization
    init(presenter: ParametersPresentationLogic, worker: ParametersWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStartData(request: ParametersModels.LoadStart.Request) {
        let response = ParametersModels.LoadStart.Response(
            titleText: configuredTitle(),
            tableTitleText: Constants.tableTitleText,
            settingsImageName: Constants.settingsImageName
        )
        presenter.presentStart(response: response)
    }
    
    func loadSettings(request: ParametersModels.LoadSettings.Request) {
        let response = ParametersModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
    
    func loadParameter(request: ParametersModels.LoadParameter.Request) {
        guard let parameterType = MedParameterType(rawValue: request.parameterTitle) else {
            return
        }
        
        let response = ParametersModels.LoadParameter.Response(id: request.id, parameterType: parameterType)
        presenter.presentParameter(response: response)
    }
    
    // MARK: - Private functions
    private func configuredTitle() -> NSMutableAttributedString {
        let titleLabelText = Constants.medViewLabelText
        let attributedTitleText = NSMutableAttributedString(string: titleLabelText)
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: UIColor.textPrimary,
                range: NSRange(
                    location: Constants.systemColorStringLocation,
                    length: Constants.systemColorStringLength
                )
            )
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: Constants.mainColor,
                range: NSRange(
                    location: Constants.mintColorStringLocation,
                    length: Constants.mintColorStringLength
                )
            )
        return attributedTitleText
    }
}

// MARK: - UITableViewDataSource
extension ParametersInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.parameterCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ParameterCell.id, for: indexPath)
        guard let parameterCell = cell as? ParameterCell else {
            return cell
        }
        let title = MedParameterType.allCases[indexPath.row].rawValue
        var image: UIImage?
        var color: UIColor = UIColor()
        switch indexPath.row {
        case 0:
            image = UIImage(systemName: "figure.run")
            color = .main
        case 1:
            image = UIImage(systemName: "waveform.path.ecg")
            color = .pulse
        case 2:
            image = UIImage(systemName: "lungs")
            color = .saturation
        case 3:
            image = UIImage(systemName: "bed.double")
            color = .sleepHours
        case 4:
            image = UIImage(systemName: "apple.meditate")
            color = .stressLevel
        case 5:
            image = UIImage(systemName: "thermometer.variable.and.figure")
            color = .temperature
        case 6:
            image = UIImage(systemName: "scalemass")
            color = .weight
        case 7:
            image = UIImage(systemName: "bubbles.and.sparkles")
            color = .bloodGlucose
        default:
            break
        }
        
        guard let parameterImage = image else {
            return cell
        }
        
        parameterCell.configure(with: parameterImage, and: title, parameterColor: color)
            
        return parameterCell
    }
}
