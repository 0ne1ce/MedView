//
//  AbourDevPresenter.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import UIKit
import Foundation
import MapKit

final class AbourDevPresenter: AboutDevPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        static let regionDelta: Double = 0.01
    }
    
    // MARK: - Properties
    weak var view: AboutDevDisplayLogic?
    
    func presentStart(response: AboutDevModels.LoadStart.Response) {
        let coordinate = CLLocationCoordinate2D(
            latitude: response.hseLocationLatitude,
            longitude: response.hseLocationLongtitude
        )
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: Constants.regionDelta, longitudeDelta: Constants.regionDelta)
        )
        
        let annotation = MKPointAnnotation(
            __coordinate: coordinate,
            title: response.hseLocationAnnotationTitle,
            subtitle: response.hseLocationAnnotationSubtitle
        )
        let viewModel = AboutDevModels.LoadStart.ViewModel(
            backgroundColorHex: Constants.backgroundLightHex,
            hseLocationRegion: region,
            hseAnnotation: annotation
        )
        view?.displayStart(viewModel: viewModel)
    }
    
}
