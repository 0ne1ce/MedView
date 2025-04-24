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
    
    func showAssistant(with data: [ChartDataPoint], and parameterName: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let tabBarController = window.rootViewController as? TabBarController,
              let assistantNav = tabBarController.viewControllers?[1] as? UINavigationController,
              let assistantVC = assistantNav.viewControllers.first as? AssistantViewController else {
                return
        }

        assistantVC.loadUserAdvice(with: data, and: parameterName)
        tabBarController.selectedIndex = 1
        view?.dismiss(animated: true)
    }
}
