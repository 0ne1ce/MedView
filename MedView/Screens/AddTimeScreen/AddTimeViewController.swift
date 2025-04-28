//
//  AboutDevViewController.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit
import MapKit

final class AddTimeViewController: UIViewController, AddTimeDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let timeSetupTableOffsetTop: CGFloat = 75
        static let timeSetupTableOffsetHorizontal: CGFloat = 10
        static let timeSetupTableRadius: CGFloat = 15
        
        static let heightForRow: CGFloat = 45
        
        static let numberOfItems: CGFloat = 2
        static let separationLineWidth: CGFloat = 1
        
        static let pickerContainerRadius: CGFloat = 15
        static let pickerContainerSize: CGFloat = 300
        
        static let addButtonHeight: CGFloat = 55
        static let addButtonOffsetH: CGFloat = 60
        static let addButtonOffsetBottom: CGFloat = 40
        static let addButtonRadius: CGFloat = 15
    }
    
    // MARK: - Properties
    var interactor: AddTimeBuisnessLogic
    var router: AddTimeRouterProtocol

    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    var timeSetupTable: UITableView = UITableView()
    var timePicker = UIDatePicker()
    var pickerContainerView = UIView()
    var dimmedView = UIView()
    var addButton: UIButton = UIButton(type: .system)

    private var selectedTime: Date?
    
    private var timestampAdded: ((Timestamp) -> Void)?
    
    // MARK: - Initialization
    init(interactor: AddTimeBuisnessLogic, router: AddTimeRouterProtocol, timestampAdded: @escaping ((Timestamp) -> Void)) {
        self.interactor = interactor
        self.router = router
        self.timestampAdded = timestampAdded
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStart()
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = AddTimeModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AddTimeModels.LoadStart.ViewModel) {
        view.backgroundColor = viewModel.backgroundColor
        configureTimePicker(currentTimestamp: viewModel.currentTimestamp)
        configureTimeSetupTable()
        configureAddButton(with: viewModel)
    }
    
    func displayTimestamp(viewModel: AddTimeModels.TimestampCreation.ViewModel) {
        timestampAdded?(viewModel.timestamp)
        let request = AddTimeModels.LoadNotification.Request()
        interactor.loadNotification(request: request)
    }
    
    func displayNotification(viewModel: AddTimeModels.LoadNotification.ViewModel) {
        router.showNotification()
    }
    
    // MARK: - Private functions
    private func configure() {
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonPressed)
        )
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureTimeSetupTable() {
        timeSetupTable.register(TimeSetupCell.self, forCellReuseIdentifier: TimeSetupCell.reuseId)
        timeSetupTable.delegate = self
        timeSetupTable.dataSource = interactor
        
        timeSetupTable.backgroundColor = .clear
        timeSetupTable.separatorStyle = .singleLine
        timeSetupTable.allowsSelection = false
        timeSetupTable.isScrollEnabled = false
        
        view.addSubview(timeSetupTable)
        timeSetupTable.pinHorizontal(to: view, Constants.timeSetupTableOffsetHorizontal)
        timeSetupTable.pinTop(to: view.topAnchor, Constants.timeSetupTableOffsetTop)
        timeSetupTable.setHeight(Constants.numberOfItems * Constants.heightForRow - Constants.separationLineWidth)
        timeSetupTable.layer.cornerRadius = Constants.timeSetupTableRadius
        
        timeSetupTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    }
    
    private func configureTimePicker(currentTimestamp: Timestamp?) {
        view.addSubview(pickerContainerView)

        pickerContainerView.pinCenter(to: view)
        pickerContainerView.setWidth(Constants.pickerContainerSize)
        pickerContainerView.setHeight(Constants.pickerContainerSize)

        pickerContainerView.backgroundColor = .backgroundPrimary
        pickerContainerView.layer.cornerRadius = Constants.pickerContainerRadius
        pickerContainerView.clipsToBounds = true
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        if let timeString = currentTimestamp?.time {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let date = formatter.date(from: timeString)
            timePicker.date = date ?? Date()
        } else {
            timePicker.date = Date()
        }

        pickerContainerView.addSubview(timePicker)
        timePicker.pinHorizontal(to: pickerContainerView)
        timePicker.pinVertical(to: pickerContainerView)

        timePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private func configureAddButton(with viewModel: AddTimeModels.LoadStart.ViewModel) {
        view.addSubview(addButton)
        addButton.pinHorizontal(to: view, Constants.addButtonOffsetH)
        addButton.pinBottom(to: view.bottomAnchor, Constants.addButtonOffsetBottom)
        addButton.setHeight(Constants.addButtonHeight)
        
        addButton.setTitle(viewModel.addButtonText, for: .normal)
        addButton.titleLabel?.textAlignment = .left
        addButton.titleLabel?.font = viewModel.addButtonFont
        addButton.setTitleColor(viewModel.addButtonTextColor, for: .normal)
        addButton.backgroundColor = viewModel.addButtonColor
        addButton.layer.cornerRadius = Constants.addButtonRadius
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }

    // MARK: - Actions
    @objc func cancelButtonPressed() {
        let request = AddTimeModels.LoadNotification.Request()
        interactor.loadNotification(request: request)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: sender.date)
        guard let timeSetupCell = timeSetupTable.cellForRow(at: IndexPath(row: .zero, section: .zero)) as? TimeSetupCell else {
            return
        }
        timeSetupCell.valueTextField.text = timeString
    }
    
    @objc func addButtonPressed() {
        triggerSelectionFeedback()
        guard let timeSetupCell = timeSetupTable.cellForRow(at: IndexPath(row: .zero, section: .zero)) as? TimeSetupCell else {
            return
        }
        guard let newTime = timeSetupCell.valueTextField.text else {
            return
        }
        let addRequest = AddTimeModels.TimestampCreation.Request(timeString: newTime)
        interactor.loadTimeString(request: addRequest)
    }
}

// MARK: - UITableViewDelegate
extension AddTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
}
