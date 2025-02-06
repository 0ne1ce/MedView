//
//  HelpViewController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpViewController: UIViewController, HelpDisplayLogic {
    // MARK: - Properties
    var interactor: (HelpBuisnessLogic & HelpDataStore)?
    var router: HelpRouterProtocol?
    var helpView: HelpView = HelpView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = helpView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private functions
    private func configure() {
        interactor?.configureNavigationBar()
    }
    
    private func configureButtonTarget() {
        helpView.helpNavigation.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    // MARK: - Public functions
    public func displayNavigationBar(with viewModel: any CustomNavigationBarViewModel) {
        if (viewModel.isSettingsButtonHidden == false) {
            configureButtonTarget()
        }
        helpView.helpNavigation.configure(with: viewModel)
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        router?.showSettingsScreen()
    }
}
