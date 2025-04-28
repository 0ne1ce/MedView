//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class NotificationViewController: UIViewController, NotificationDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 155
        
        static let tableViewTopOffset: CGFloat = 50
        
        static let timeTableTitleOffsetBottom: CGFloat = 10
        static let timeTableTitleOffsetLeft: CGFloat = 20
        
        static let heightForRow: CGFloat = 90
        static let heightForRowAnimated: CGFloat = 100
        
        static let usingSpringWithDampingValue: CGFloat = 0.65
        static let initialSpringVelocityValue: CGFloat = 0.5
        static let cellsAnimationDuration: CGFloat = 0.85
        static let delayFactor: CGFloat = 0.05
    }
    
    // MARK: - Properties
    var interactor: NotificationBuisnessLogic
    var router: NotificationRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    let aboutDevButton: UIButton = UIButton(type: .system)
    var settingsTable: UITableView = UITableView()
    var timeTable: UITableView = UITableView()
    var tableTitle: UILabel = UILabel()
    
    // MARK: - Initialization
    init(interactor: NotificationBuisnessLogic, router: NotificationRouterProtocol) {
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
        loadStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = NotificationModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: NotificationModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel, false, true)
        view.addSubview(navigationBar)
        configureAddButtonTarget()
        
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        configureTable(with: viewModel)
        configureTableTitle(with: viewModel)
    }
    
    func displayAddTimeScreen(viewModel: NotificationModels.LoadAddTimeScreen.ViewModel) {
        router.showAddTimeScreen(currentTimestamp: viewModel.timestamp, timestampAdded: { [weak self] timeStamp in
            let request = NotificationModels.AddTimestamp.Request(timestamp: timeStamp)
            self?.interactor.loadTimestamp(request: request)
        })
    }
    
    func displayTimestamp(viewModel: NotificationModels.AddTimestamp.ViewModel) {
        timeTable.reloadData()
    }
    
    func displayTimestampsAfterDeletion(viewModel: NotificationModels.DeleteTimestamp.ViewModel) {
        timeTable.deleteRows(
            at: [IndexPath(row: viewModel.index, section: .zero)],
            with: .left
        )
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = .backgroundPrimary
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureAddButtonTarget() {
        navigationBar.buttonTarget(target: self, action: #selector(addButtonPressed))
    }
    
    private func configureTable(with viewModel: NotificationModels.LoadStart.ViewModel) {
        timeTable.register(TimestampCell.self, forCellReuseIdentifier: TimestampCell.reuseId)
        timeTable.delegate = self
        timeTable.dataSource = interactor
        
        timeTable.backgroundColor = viewModel.tableBackgroundColor
        timeTable.separatorStyle = .none
        timeTable.allowsSelection = true
        
        view.addSubview(timeTable)
        timeTable.pinHorizontal(to: view)
        timeTable.pinBottom(to: view)
        timeTable.pinTop(to: navigationBar.bottomAnchor, Constants.tableViewTopOffset)
    }
    
    private func configureTableTitle(with viewModel: NotificationModels.LoadStart.ViewModel) {
        tableTitle.text = viewModel.tableTitleText
        tableTitle.textColor = viewModel.tableTitleColor
        tableTitle.textAlignment = .left
        tableTitle.font = viewModel.tableTitleFont
        
        view.addSubview(tableTitle)
        tableTitle.pinBottom(to: timeTable.topAnchor, Constants.timeTableTitleOffsetBottom)
        tableTitle.pinLeft(to: view, Constants.timeTableTitleOffsetLeft)
        tableTitle.pinRight(to: view)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    private func moveUpBounceAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath in
            cell.transform = CGAffineTransform(translationX: .zero, y: rowHeight)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: Constants.usingSpringWithDampingValue,
                initialSpringVelocity: Constants.initialSpringVelocityValue,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: .zero, y: .zero)
                }
            )
        }
    }
    
    // MARK: - Actions
    @objc func addButtonPressed() {
        let request = NotificationModels.LoadAddTimeScreen.Request()
        interactor.loadAddTimeScreen(request: request)
    }
}

// MARK: - UITableViewDelegate
extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
        
        let request = NotificationModels.LoadAddTimeScreen.Request(index: indexPath.row)
        interactor.loadAddTimeScreen(request: request)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = moveUpBounceAnimation(
            rowHeight: Constants.heightForRowAnimated,
            duration: Constants.cellsAnimationDuration,
            delayFactor: Constants.delayFactor
        )
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completionHandler in 
            
            let request = NotificationModels.DeleteTimestamp.Request(index: indexPath.row)
            self?.interactor.deleteTimestamp(request: request)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .backgroundPrimary
        deleteAction.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
