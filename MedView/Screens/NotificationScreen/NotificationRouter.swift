//
//  SettingsRouter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class NotificationRouter: NotificationRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    func showAddTimeScreen() {
        let addTimeScreenVC = UINavigationController(rootViewController: AddTimeAssembly.build())
        view?.present(addTimeScreenVC, animated: true)
    }
}
