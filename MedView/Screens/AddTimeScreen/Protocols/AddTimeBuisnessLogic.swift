//
//  AboutDevBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//
import UIKit

protocol AddTimeBuisnessLogic: AnyObject, UITableViewDataSource {
    // MARK: - Functions
    func loadStart(request: AddTimeModels.LoadStart.Request)
}
