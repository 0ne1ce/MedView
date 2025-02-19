//
//  HelpRouter.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpRouter: HelpRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    func showSettingsScreen() {
        let settingsVC = SettingsAssembly.build()
        settingsVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
