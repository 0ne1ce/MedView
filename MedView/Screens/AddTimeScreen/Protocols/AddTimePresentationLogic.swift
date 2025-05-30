//
//  AbourDevPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

protocol AddTimePresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: AddTimeModels.LoadStart.Response)
    func presentNotification(response: AddTimeModels.LoadNotification.Response)
    func presentTimestamp(response: AddTimeModels.TimestampCreation.Response)
}
