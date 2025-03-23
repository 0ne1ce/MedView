//
//  MedParameterAssembly.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//
import UIKit

final class MedParameterAssembly {
    static func build() -> UIViewController {
        let presenter = MedParameterPresenter()
        let worker = MedParameterWorker()
        
        let interactor = MedParameterInteractor(presenter: presenter, worker: worker)
        let router = MedParameterRouter()
        
        let view = MedParameterViewController(interactor: interactor, router: router)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
