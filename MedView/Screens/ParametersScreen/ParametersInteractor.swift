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
        
        static let mainColorHex: String = "00C7C0"
        
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
        let response = ParametersModels.LoadParameter.Response()
        presenter.presentParameter(response: response)
    }
    
    // MARK: - Private functions
    private func configuredTitle() -> NSMutableAttributedString {
        let titleLabelText = Constants.medViewLabelText
        let attributedTitleText = NSMutableAttributedString(string: titleLabelText)
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: UIColor.black,
                range: NSRange(
                    location: Constants.systemColorStringLocation,
                    length: Constants.systemColorStringLength
                )
            )
        attributedTitleText
            .addAttribute(
                .foregroundColor,
                value: UIColor(hex: Constants.mainColorHex),
                range: NSRange(
                    location: Constants.mintColorStringLocation,
                    length: Constants.mintColorStringLength
                )
            )
        return attributedTitleText
    }
}

extension ParametersInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.parameterCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ParameterCell.id, for: indexPath)
        guard let parameterCell = cell as? ParameterCell else {
            return cell
        }
            
        let title = ParametersColorsTitles.allCases[indexPath.row].rawValue
        guard let image = UIImage(named: title) else {
            return cell
        }
        parameterCell.configure(with: image, and: title)
            
        return parameterCell
    }
}
