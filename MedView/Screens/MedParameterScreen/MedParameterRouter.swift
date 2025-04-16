//
//  MedParameterRouter.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import UIKit
import Foundation

final class MedParameterRouter: MedParameterRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    func showSettingsScreen() {
        let settingsVC = SettingsAssembly.build()
        view?.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
