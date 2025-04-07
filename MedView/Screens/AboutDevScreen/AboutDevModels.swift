//
//  AboutDevModels.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit
import MapKit

enum AboutDevModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var hseLocationLatitude: Double
            var hseLocationLongtitude: Double
            var hseLocationAnnotationTitle: String
            var hseLocationAnnotationSubtitle: String
        }
        
        struct ViewModel {
            var backgroundColorHex: String
            var hseLocationRegion: MKCoordinateRegion
            var hseAnnotation: MKPointAnnotation
        }
    }
}
