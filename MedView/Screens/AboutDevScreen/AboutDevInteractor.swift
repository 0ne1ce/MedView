//
//  AboutDevInteractor.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation
import MapKit

final class AboutDevInteractor: AboutDevBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let hseLatitude: Double = 55.754082
        static let hseLongtitude: Double = 37.648754
        static let hseAnnotationTitle: String = "HSE"
        static let hseAnnotationSubtitle: String = "FCS Software Engineering"
        static let hseAuthor: String = "Chernyy A. V."
    }
    
    // MARK: - Properties
    var presenter: AboutDevPresentationLogic
    var worker: AboutDevWorker
    
    // MARK: - Initialization
    init(presenter: AboutDevPresentationLogic, worker: AboutDevWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: AboutDevModels.LoadStart.Request) {
        let response = AboutDevModels.LoadStart.Response(
            hseLocationLatitude: Constants.hseLatitude,
            hseLocationLongtitude: Constants.hseLongtitude,
            hseLocationAnnotationTitle: Constants.hseAnnotationTitle,
            hseLocationAnnotationSubtitle: Constants.hseAnnotationSubtitle,
            hseAuthor: Constants.hseAuthor
        )
        presenter.presentStart(response: response)
    }
}
