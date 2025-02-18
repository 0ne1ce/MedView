//
//  ParametersPresenter.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersPresenter: ParametersPresentationLogic {
    // MARK: - Properties
    weak var view: ParametersDisplayLogic?
    
    // MARK: - Variables
    var settingsButton: UIButton = UIButton()
    var title: UILabel = UILabel()
    var borderline: UIView = UIView()
    var tableView: UITableView = UITableView()
    var tableTitle: UILabel = UILabel()
    
    // MARK: - Private functions
    private func configureButton() {
        let settingsImage = ParametersConstants.settingsImage
        settingsButton.backgroundColor = .clear
        settingsButton.setImage(settingsImage, for: .normal)
    }
    
    private func configureTable() {
        tableView.backgroundColor = UIColor(hex: ParametersConstants.backgroundLightHex)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
    }
    
    // MARK: - Public Fuctions
    func presentNavigationBar(response: ParametersModels.FetchNavigationBar.Response) {
        title.attributedText = response.titleText
        let font = ParametersConstants.navigationTitleFont
        title.font = font.bold
        borderline.backgroundColor = .lightGray
        configureButton()
        
        let viewModel = ParametersModels.FetchNavigationBar.ViewModel(
            title: title,
            settingsButton: settingsButton,
            backgroundColor: .white,
            borderline: borderline
        )
        
        view?.displayNavigationBar(viewModel: viewModel)
    }
    
    func presentParameters(response: ParametersModels.FetchParameters.Response) {
        tableTitle.text = response.tableTitleText
        tableTitle.textColor = UIColor(hex: ParametersConstants.parametersTitleLabelHex)
        tableTitle.textAlignment = .left
        tableTitle.font = ParametersConstants.parametersFont
        
        configureTable()
        let viewModel = ParametersModels.FetchParameters.ViewModel(
            tableView: tableView,
            tableTitle: tableTitle
        )
        
        view?.displayParameters(viewModel: viewModel)
    }
}
