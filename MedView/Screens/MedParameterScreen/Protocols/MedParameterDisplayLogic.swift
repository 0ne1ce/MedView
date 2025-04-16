//
//  MedParameterDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

protocol MedParameterDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: MedParameterModels.LoadStart.ViewModel)
    func displayTextFieldValue(viewModel: MedParameterModels.SaveValue.ViewModel)
    func displayAferDeletion(viewModel: MedParameterModels.DeleteData.ViewModel)
    func displaySettings(viewModel: MedParameterModels.LoadSettings.ViewModel)
}
