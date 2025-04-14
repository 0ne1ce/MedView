//
//  SettingsRouter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsRouter: SettingsRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Fuctions
    func showAboutDevScreen() {
        let aboutDevVC = AboutDevAssembly.build()
        view?.present(aboutDevVC, animated: true)
    }
    
    func showCardScreen() {
        let cardVC = CardAssembly.build()
        view?.navigationController?.pushViewController(cardVC, animated: true)
    }
    
    func showNotificationScreen() {
        let notificationVC = NotificationAssembly.build()
        view?.navigationController?.pushViewController(notificationVC, animated: true)
    }
}
