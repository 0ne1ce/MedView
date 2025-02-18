//
//  Assembly.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersAssembly {
    // MARK: - Functions
    static func build() -> UIViewController {
        let presenter = ParametersPresenter()
        let worker = ParametersWorker()
        let interactor = ParametersInteractor(presenter: presenter, worker: worker)
        let router = ParametersRouter()
        let view = ParametersViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
