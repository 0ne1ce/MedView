//
//  AboutDevDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

protocol AddTimeDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: AddTimeModels.LoadStart.ViewModel)
    func displayNotification(viewModel: AddTimeModels.LoadNotification.ViewModel)
    func displayTimestamp(viewModel: AddTimeModels.TimestampCreation.ViewModel)
}
