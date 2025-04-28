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
    func showAddTimeScreen(currentTimestamp: Timestamp?, timestampAdded: @escaping (Timestamp) -> Void) {
        let addTimeScreenVC = AddTimeAssembly.build(currentTimestamp: currentTimestamp, timestampAdded: timestampAdded)
        let addTimeScreenNavVC = UINavigationController(rootViewController: addTimeScreenVC)
        view?.present(addTimeScreenNavVC, animated: true)
    }
}
