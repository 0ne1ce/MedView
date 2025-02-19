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
        let presenter = AssistantPresenter()
        let worker = AssistantWorker()
        let interactor = AssistantInteractor(presenter: presenter, worker: worker)
        let router = AssistantRouter()
        let view = AssistantViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
