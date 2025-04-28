//
//  AboutDevRouter.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation

final class AddTimeRouter: AddTimeRouterProtocol {
    // MARK: - Properties
    weak var view: UIViewController?
    
    func showNotification() {
        view?.dismiss(animated: true)
    }
}
