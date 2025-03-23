//
//  ViewController.swift
//  MedView
//
//  Created by Алексей on 14.01.2025.
//

import Foundation
import UIKit

typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

final class ParametersViewController: UIViewController, ParametersDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let tableViewTopOffset: CGFloat = 175
        static let heightForRow: CGFloat = 60
        static let heightForRowAnimated: CGFloat = 100
        
        static let parametersOffsetBottom: CGFloat = 10
        static let parametersOffsetLeft: CGFloat = 20
        
        static let navigationBarHeight: CGFloat = 120
        
        static let usingSpringWithDampingValue: CGFloat = 0.65
        static let initialSpringVelocityValue: CGFloat = 0.5
        static let cellsAnimationDuration: CGFloat = 0.85
        static let delayFactor: CGFloat = 0.05
    }
    
    // MARK: - Properties
    var interactor: ParametersBuisnessLogic
    var router: ParametersRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Variables
    var tableView: UITableView = UITableView()
    var tableTitle: UILabel = UILabel()
    
    // MARK: - Initialization
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
        tableView.reloadData()
        loadStart()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Public Functions
    func loadStart() {
        let request = ParametersModels.LoadStart.Request()
        interactor.loadStartData(request: request)
    }
    
    func displayStart(viewModel: ParametersModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel)
        configureSettingsButtonTarget()
        
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        configureTable(with: viewModel)
        configureTableTitle(with: viewModel)
    }
    
    func displaySettings(viewModel: ParametersModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    func displayParamter(viewModel: ParametersModels.LoadParameter.ViewModel) {
        router.showParameter()
    }
    
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = UIColor(hex: Constants.backgroundLightHex)
    }
    
    private func configureTable(with viewModel: ParametersModels.LoadStart.ViewModel) {
        tableView.register(ParameterCell.self, forCellReuseIdentifier: ParameterCell.id)
        tableView.register(AddParamterCell.self, forCellReuseIdentifier: AddParamterCell.id)
        tableView.delegate = self
        tableView.dataSource = interactor
        
        tableView.backgroundColor = viewModel.tableBackgroundColor
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        tableView.pinHorizontal(to: view)
        tableView.pinBottom(to: view)
        tableView.pinTop(to: view, Constants.tableViewTopOffset)
    }
    
    private func configureTableTitle(with viewModel: ParametersModels.LoadStart.ViewModel) {
        tableTitle.text = viewModel.tableTitleText
        tableTitle.textColor = viewModel.tableTitleColor
        tableTitle.textAlignment = .left
        tableTitle.font = viewModel.tableTitleFont
        
        view.addSubview(tableTitle)
        tableTitle.pinBottom(to: tableView.topAnchor, Constants.parametersOffsetBottom)
        tableTitle.pinLeft(to: view, Constants.parametersOffsetLeft)
        tableTitle.pinRight(to: view)
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    private func moveUpBounceAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: .zero, y: rowHeight)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: Constants.usingSpringWithDampingValue,
                initialSpringVelocity: Constants.initialSpringVelocityValue,
                options: [.curveEaseInOut],
                animations:  {
                    cell.transform = CGAffineTransform(translationX: .zero, y: .zero)
                }
            )
        }
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = ParametersModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
}

// MARK: - UITableViewDelegate
extension ParametersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
        let request = ParametersModels.LoadParameter.Request()
        interactor.loadParameter(request: request)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = moveUpBounceAnimation(
            rowHeight: Constants.heightForRowAnimated,
            duration: Constants.cellsAnimationDuration,
            delayFactor: Constants.delayFactor
        )
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, for: tableView)
    }
}
