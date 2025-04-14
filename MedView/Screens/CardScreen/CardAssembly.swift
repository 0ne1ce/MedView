//
//  SettingsAssembly.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class CardAssembly {
    // MARK: - Funtions
    static func build() -> UIViewController {
        let presenter = CardPresenter()
        let worker = CardWorker()
        let interactor = CardInteractor(presenter: presenter, worker: worker)
        let router = CardRouter()
        let view = CardViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
