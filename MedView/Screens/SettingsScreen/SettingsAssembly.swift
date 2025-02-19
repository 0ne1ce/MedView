//
//  SettingsAssembly.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsAssembly {
    // MARK: - Funtions
    static func build() -> UIViewController {
        let view = SettingsViewController()
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()
        
        let router = SettingsRouter()
        let worker = SettingsWorker()
        
        view.interactor = interactor
        view.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
