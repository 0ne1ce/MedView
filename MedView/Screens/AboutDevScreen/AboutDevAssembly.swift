//
//  AboutDevAssembly.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation

final class AboutDevAssembly {
    static func build() -> UIViewController {
        let presenter = AboutDevPresenter()
        let worker = AboutDevWorker()
        
        let interactor = AboutDevInteractor(presenter: presenter, worker: worker)
        let router = AboutDevRouter()
        
        let view = AboutDevViewController(interactor: interactor, router: router)
        
        router.view = view
        presenter.view = view
        
        return view
        
    }
}
