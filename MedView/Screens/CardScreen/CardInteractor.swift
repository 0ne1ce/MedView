//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class CardInteractor: NSObject, CardBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let cardLabelText: NSMutableAttributedString = NSMutableAttributedString("Your card")
        static let numberOfRows: Int = 3
        static let cardParameters: [String] = [
            "Blood group",
            "Allergies",
            "Chronic diseases"
        ]
    }
    
    // MARK: - Properties
    var presenter: CardPresentationLogic
    var worker: CardWorker
    
    var valuesArray: [String] = []
    
    // MARK: - Initialization
    init(presenter: CardPresentationLogic, worker: CardWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: CardModels.LoadStart.Request) {
        valuesArray = [
            worker.loadBloodGroup(),
            worker.loadAllergies(),
            worker.loadChronicDiseases()
        ]
        let response = CardModels.LoadStart.Response(
            titleText: Constants.cardLabelText
        )
        presenter.presentStart(response: response)
    }
    
    func saveTextFieldValue(request: CardModels.SaveValue.Request) {
        switch request.parameterTag {
        case 0:
            worker.saveBloodGroup(request.value)
        case 1:
            worker.saveAllergies(request.value)
        case 2:
            worker.saveChronicDiseases(request.value)
        default:
            break
        }
        let response = CardModels.SaveValue.Response()
        presenter.presentTextFieldValue(response: response)
    }
}

// MARK: - UITableViewDataSource
extension CardInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseId, for: indexPath)
        guard let cardCell = cell as? CardCell else {
            return cell
        }
        cardCell.configure(with: Constants.cardParameters[indexPath.row], valuesArray[indexPath.row])
        return cardCell
    }
}
