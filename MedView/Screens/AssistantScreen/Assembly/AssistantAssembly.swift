//
//  AssistantAssembly.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantAssembly {
    // MARK: - Functions
    static func build() -> UIViewController {
        let view = AssistantViewController()
        let interactor = AssistantInteractor()
        let presenter = AssistantPresenter()
        
        let worker = AssistantWorker()
        let router = AssistantRouter()
        
        view.router = router
        view.interactor = interactor
        
        interactor.worker = worker
        interactor.presenter = presenter
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
