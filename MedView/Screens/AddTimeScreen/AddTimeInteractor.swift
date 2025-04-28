//
//  AboutDevInteractor.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation
import MapKit

final class AddTimeInteractor: NSObject, AddTimeBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let numberOfRows: Int = 2
        static let timeSetupParameters: [String] = [
            "Time",
            "Repeat"
        ]
        
        static let addButtonText: String = "Add"
    }
    
    // MARK: - Properties
    var presenter: AddTimePresentationLogic
    var worker: AddTimeWorker
    var currentTimestamp: Timestamp?
    
    var repeatStatus: Bool = false
    
    // MARK: - Initialization
    init(presenter: AddTimePresentationLogic, worker: AddTimeWorker, currentTimestamp: Timestamp?) {
        self.presenter = presenter
        self.worker = worker
        self.currentTimestamp = currentTimestamp
    }
    
    // MARK: - Public functions
    func loadStart(request: AddTimeModels.LoadStart.Request) {
        if let timestamp = currentTimestamp {
            repeatStatus = timestamp.repeatStatus
        }
        let response = AddTimeModels.LoadStart.Response(addButtonText: Constants.addButtonText, currentTimestamp: currentTimestamp)
        presenter.presentStart(response: response)
    }
    
    func loadNotification(request: AddTimeModels.LoadNotification.Request) {
        let response = AddTimeModels.LoadNotification.Response()
        presenter.presentNotification(response: response)
    }
    
    func loadTimeString(request: AddTimeModels.TimestampCreation.Request) {
        let response = AddTimeModels.TimestampCreation.Response(
            timeString: request.timeString,
            repeatStatus: repeatStatus
        )
        presenter.presentTimestamp(response: response)
    }
}

// MARK: - UITableViewDataSource
extension AddTimeInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeSetupCell.reuseId, for: indexPath)
        guard let timeSetupCell = cell as? TimeSetupCell else {
            return cell
        }
        
        timeSetupCell.switchValueChanged = { [weak self] isOn in
            self?.repeatStatus = isOn
        }
        
        timeSetupCell.configure(
            with: Constants.timeSetupParameters[indexPath.row],
            "",
            index: indexPath.row,
            toggleState: repeatStatus,
            currentTimestamp: currentTimestamp
        )
        return timeSetupCell
    }
}
