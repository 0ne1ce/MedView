//
//  Assembly.swift
//  MedView
//
//  Created by Алексей on 01.02.2025.
//

import Foundation
import UIKit

final class ParametersAssembly: NSObject {
    // MARK: - Functions
    class func configuredModule() -> UIViewController {
        let view = ParametersViewController()
        let interactor = ParametersInteractor()
        let presenter = ParametersPresenter()
        
        let router = ParametersRouter()
        let worker = ParametersWorker()
        
        view.interactor = interactor
        view.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
