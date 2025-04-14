//
//  SettingsAssembly.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class NotificationAssembly {
    // MARK: - Funtions
    static func build() -> UIViewController {
        let presenter = NotificationPresenter()
        let worker = NotificationWorker()
        let interactor = NotificationInteractor(presenter: presenter, worker: worker)
        let router = NotificationRouter()
        let view = NotificationViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
