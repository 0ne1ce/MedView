//
//  ViewController.swift
//  MedView
//
//  Created by Алексей on 14.01.2025.
//

import Foundation
import UIKit

class ParametersViewController: UIViewController, ParametersDisplayLogic {
    // MARK: - Properties
    var interactor: (ParametersBuisnessLogic & ParametersDataStore)?
    var router: ParametersRouterProtocol?
    var parametersView: ParametersView = ParametersView()
    let customNavigation: CustomNavigationBarView = CustomNavigationBarView()
    //let settingsButton: UIButton = UIButton(type: .custom)

    // MARK: - Lifecycle
    override func loadView() {
        view = parametersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    // MARK: - Private functions
    private func configure() {
        //settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(customNavigation)
        customNavigation.pinTop(to: view.topAnchor)
        customNavigation.pinBottom(to: view.safeAreaLayoutGuide.topAnchor, -30)
        customNavigation.pinLeft(to: view.leadingAnchor)
        customNavigation.pinRight(to: view.trailingAnchor)
        
        configureSettingsButton()
    }
    
    private func configureSettingsButton() {
//        let settingsImage = UIImage(named: Constants.CustomNavigationBarView.settingsSymbol)
//        settingsButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.CustomNavigationBarView.settingsButtonSize)
//        settingsButton.setTitleColor(.systemMint, for: .normal)
//        settingsButton.backgroundColor = .clear
//        settingsButton.setImage(settingsImage, for: .normal)
//
//        view.addSubview(settingsButton)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
//        settingsButton.setWidth(Constants.CustomNavigationBarView.settingsButtonSize)
//        settingsButton.setHeight(Constants.CustomNavigationBarView.settingsButtonSize)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

}

