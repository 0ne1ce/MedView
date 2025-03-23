//
//  ParametersRouter.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersRouter: ParametersRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    func showSettingsScreen() {
        let settingsVC = SettingsAssembly.build()
        settingsVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showParameter() {
        let medParameterVC = MedParameterAssembly.build()
        view?.present(medParameterVC, animated: true)
    }
}
