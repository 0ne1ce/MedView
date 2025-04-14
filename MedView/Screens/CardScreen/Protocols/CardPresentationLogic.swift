//
//  SettingsPresentationLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol CardPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: CardModels.LoadStart.Response)
}
