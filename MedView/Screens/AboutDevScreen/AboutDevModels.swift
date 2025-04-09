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
            var hseAuthor: String
        }
        
        struct ViewModel {
            var backgroundColorHex: String
            var hseLocationRegion: MKCoordinateRegion
            var hseAnnotation: MKPointAnnotation
            var hseAuthor: String
            var infoFont: UIFont
            var hseImage: UIImage?
        }
    }
}
