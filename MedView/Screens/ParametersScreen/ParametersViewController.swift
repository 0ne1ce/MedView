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
    var interactor: ParametersBuisnessLogic
    var router: ParametersRouterProtocol
    
    // MARK: - Variables
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    init(interactor: ParametersBuisnessLogic, router: ParametersRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        fetchNavigationBar()
        fetchParameters()
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
        view.backgroundColor = UIColor(hex: ParametersConstants.backgroundLightHex)
    }
    
    private func configureButtonTarget() {
        navigationBar.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Public Functions
    func fetchNavigationBar() {
        let request = ParametersModels.FetchNavigationBar.Request()
        interactor.fetchNavigationBar(request: request)
    }
    
    func displayNavigationBar(viewModel: ParametersModels.FetchNavigationBar.ViewModel) {
        navigationBar.confiugre(with: viewModel)
        configureButtonTarget()
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(ComponentsConstants.CustomNavigationBarView.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
    }
    
    func fetchParameters() {
        let request = ParametersModels.FetchParameters.Request()
        interactor.fetchParameters(request: request)
    }
    
    func displayParameters(viewModel: ParametersModels.FetchParameters.ViewModel) {
        viewModel.tableView.register(ParameterCell.self, forCellReuseIdentifier: ParameterCell.id)
        viewModel.tableView.register(AddParamterCell.self, forCellReuseIdentifier: AddParamterCell.id)
        viewModel.tableView.delegate = self
        // TODO: - interactor - ds
        viewModel.tableView.dataSource = self
        
        view.addSubview(viewModel.tableView)
        viewModel.tableView.pinHorizontal(to: view)
        viewModel.tableView.pinBottom(to: view)
        viewModel.tableView.pinTop(to: view, ParametersConstants.tableViewTopOffset)
        
        view.addSubview(viewModel.tableTitle)
        viewModel.tableTitle.pinBottom(to: viewModel.tableView.topAnchor, ParametersConstants.parametersOffsetBottom)
        viewModel.tableTitle.pinLeft(to: view, ParametersConstants.parametersOffsetLeft)
        viewModel.tableTitle.pinRight(to: view)
    }
    
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        router.showSettingsScreen()
    }
}

// MARK: - UITableViewDelegate
extension ParametersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ParametersConstants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ParametersConstants.parameterCellCount
        default:
            return ParametersConstants.addParamterCellCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: - Remove fatal errors
        // TODO: - Add models for cell.configure
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParameterCell.id, for: indexPath) as? ParameterCell else {
                fatalError("The TableView could not dequeue a ParameterCell in ParametersViewController")
            }
            
            let title = ParametersColors.allCases[indexPath.row].rawValue
            guard let image = UIImage(named: title) else {
                        fatalError("No image found for asset: \(title)")
                    }
            cell.configure(with: image, and: title)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddParamterCell.id, for: indexPath) as? AddParamterCell else {
                fatalError("The TableView could not dequeue a AddParameterCell in ParametersViewController")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ParametersConstants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
    }
}
