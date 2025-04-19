//
//  AboutDevInteractor.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation
import MapKit

final class AddTimeInteractor: AddTimeBuisnessLogic {
    // MARK: - Constants
    private enum Constants {

    }
    
    // MARK: - Properties
    var presenter: AddTimePresentationLogic
    var worker: AddTimeWorker
    
    // MARK: - Initialization
    init(presenter: AddTimePresentationLogic, worker: AddTimeWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: AddTimeModels.LoadStart.Request) {
        let response = AddTimeModels.LoadStart.Response()
        presenter.presentStart(response: response)
    }
}
