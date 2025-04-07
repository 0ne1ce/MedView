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
        let presenter = HelpPresenter()
        let worker = HelpWorker()
        let interactor = HelpInteractor(presenter: presenter, worker: worker)
        let router = HelpRouter()
        let view = HelpViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
