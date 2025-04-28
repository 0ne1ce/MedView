//
//  AboutDevAssembly.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation

final class AddTimeAssembly {
    static func build(currentTimestamp: Timestamp?, timestampAdded: @escaping (Timestamp) -> Void) -> UIViewController {
        let presenter = AddTimePresenter()
        let worker = AddTimeWorker()
        
        let interactor = AddTimeInteractor(presenter: presenter, worker: worker, currentTimestamp: currentTimestamp)
        let router = AddTimeRouter()
        
        let view = AddTimeViewController(
            interactor: interactor,
            router: router,
            timestampAdded: timestampAdded
        )
        
        router.view = view
        presenter.view = view
        
        return view
        
    }
}
