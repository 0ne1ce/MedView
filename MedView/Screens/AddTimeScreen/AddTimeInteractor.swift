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
    
    var repeatStatus: Bool = false
    
    // MARK: - Initialization
    init(presenter: AddTimePresentationLogic, worker: AddTimeWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: AddTimeModels.LoadStart.Request) {
        let response = AddTimeModels.LoadStart.Response(addButtonText: Constants.addButtonText)
        presenter.presentStart(response: response)
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
        
        timeSetupCell.configure(with: Constants.timeSetupParameters[indexPath.row], "", index: indexPath.row, toggleState: repeatStatus)
        return timeSetupCell
    }
}
