//
//  HelpAssembly.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpAssembly {
    // MARK: - Functions
    static func build() -> UIViewController {
        let view = HelpViewController()
        let interactor = HelpInteractor()
        let presenter = HelpPresenter()
        
        let router = HelpRouter()
        let worker = HelpWorker()
        
        view.interactor = interactor
        view.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
