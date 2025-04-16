//
//  MedParameterPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

protocol MedParameterPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: MedParameterModels.LoadStart.Response)
    func presentTextFieldValue(response: MedParameterModels.SaveValue.Response)
    func presentAfterDeletion(response: MedParameterModels.DeleteData.Response)
    func presentSettings(response: MedParameterModels.LoadSettings.Response)
}
