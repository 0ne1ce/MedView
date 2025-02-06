//
//  ParametersView.swift
//  MedView
//
//  Created by Алексей on 02.02.2025.
//

import Foundation
import UIKit

final class ParametersView: UIView {
    // MARK: - Variables
    let images: [UIImage] = [
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.bloodPressure),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.pulse),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.saturation),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.sleepHours),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.stressLevel),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.temperature),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.weight),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.bloodGlucose),
        UIImage(imageLiteralResourceName: Constants.ParametersPictures.customParameter)
    ]
    let parameters: [String] = [
        Constants.ParametersPictures.bloodPressure,
        Constants.ParametersPictures.pulse,
        Constants.ParametersPictures.saturation,
        Constants.ParametersPictures.sleepHours,
        Constants.ParametersPictures.stressLevel,
        Constants.ParametersPictures.temperature,
        Constants.ParametersPictures.weight,
        Constants.ParametersPictures.bloodGlucose,
        Constants.ParametersPictures.customParameter,
    ]
    let tableView: UITableView = UITableView()
    let parametersLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prvate functions
    private func configureUI() {
        backgroundColor = UIColor().hexToRGB(hex: Constants.backgroundLightHex)
        configureTableView()
        configureParametersLabel()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = UIColor().hexToRGB(hex: Constants.backgroundLightHex)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        addSubview(tableView)
        
        tableView.pinLeft(to: self.leadingAnchor)
        tableView.pinRight(to: self.trailingAnchor)
        tableView.pinBottom(to: self.bottomAnchor)
        tableView.pinTop(to: self.topAnchor, Constants.ParametersView.tableViewTopOffset)
    }
    
    private func configureParametersLabel() {
        addSubview(parametersLabel)
        
        parametersLabel.text = "Your health parameters"
        parametersLabel.textColor = UIColor().hexToRGB(hex: "999999")
        parametersLabel.textAlignment = .left
        parametersLabel.font = .systemFont(ofSize: Constants.ParametersView.parametersLabelFontSize, weight: .bold)
        
        parametersLabel.pinBottom(to: tableView.topAnchor, 10)
        parametersLabel.pinLeft(to: self.leadingAnchor, 20)
        parametersLabel.pinRight(to: self.trailingAnchor)
    }
}
