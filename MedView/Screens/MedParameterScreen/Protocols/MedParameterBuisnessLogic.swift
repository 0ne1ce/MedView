//
//  MedParameterBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

protocol MedParameterBuisnessLogic: AnyObject {
    // MARK: - Functions
    func loadStart(request: MedParameterModels.LoadStart.Request)
    func saveTextFieldValue(request: MedParameterModels.SaveValue.Request)
    func deleteData(request: MedParameterModels.DeleteData.Request)
    func loadSettings(request: MedParameterModels.LoadSettings.Request)
}
