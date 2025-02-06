//
//  ViewController.swift
//  MedView
//
//  Created by Алексей on 14.01.2025.
//

import Foundation
import UIKit

final class ParametersViewController: UIViewController, ParametersDisplayLogic {
    // MARK: - Properties
    var interactor: (ParametersBuisnessLogic & ParametersDataStore)?
    var router: ParametersRouterProtocol?
    var parametersView: ParametersView = ParametersView()

    // MARK: - Lifecycle
    override func loadView() {
        view = parametersView
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
        configureTableView()
    }
    
    private func configureTableView() {
        parametersView.tableView.register(ParameterCell.self, forCellReuseIdentifier: ParameterCell.id)
        parametersView.tableView.register(AddParamterCell.self, forCellReuseIdentifier: AddParamterCell.id)
        parametersView.tableView.delegate = self
        parametersView.tableView.dataSource = self
    }
    
    private func configureButtonTarget() {
        parametersView.parametersNavigation.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Public functions
    func displayNavigationBar(with viewModel: CustomNavigationBarViewModel) {
        if (viewModel.isSettingsButtonHidden == false) {
            configureButtonTarget()
        }
        parametersView.parametersNavigation.configure(with: viewModel)
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        router?.showSettingsScreen()
    }
}

extension ParametersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parametersView.images.count + Constants.ParametersView.AddParamterCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < parametersView.images.count {
            guard let cell = parametersView.tableView.dequeueReusableCell(withIdentifier: ParameterCell.id, for: indexPath) as? ParameterCell else {
                fatalError("The TableView could not dequeue a ParameterCell in ParametersViewController")
            }
            
            let image = parametersView.images[indexPath.row]
            let label = parametersView.parameters[indexPath.row]
            cell.configure(with: image, and: label)
            
            return cell
        }
        else {
            let cell = parametersView.tableView.dequeueReusableCell(withIdentifier: AddParamterCell.id, for: indexPath)
            
            guard cell is AddParamterCell else {
                return cell
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.ParametersView.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
    }
    
    
}
