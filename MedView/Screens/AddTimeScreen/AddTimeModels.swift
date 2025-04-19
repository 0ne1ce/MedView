//
//  AboutDevModels.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit
import MapKit

enum AddTimeModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var addButtonText: String
        }
        
        struct ViewModel {
            var backgroundColor: UIColor
            var addButtonText: String
            var addButtonColor: UIColor
            var addButtonTextColor: UIColor
            var addButtonFont: UIFont
        }
    }
}
