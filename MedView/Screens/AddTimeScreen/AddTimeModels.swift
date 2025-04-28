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
            var currentTimestamp: Timestamp?
        }
        
        struct ViewModel {
            var backgroundColor: UIColor
            var addButtonText: String
            var addButtonColor: UIColor
            var addButtonTextColor: UIColor
            var addButtonFont: UIFont
            var currentTimestamp: Timestamp?
        }
    }
    
    enum LoadNotification {
        struct Request {
            
        }
        
        struct Response {

        }
        
        struct ViewModel {

        }
    }
    
    enum TimestampCreation {
        struct Request {
            var timeString: String
        }
        
        struct Response {
            var timeString: String
            var repeatStatus: Bool
        }
        
        struct ViewModel {
            var timestamp: Timestamp
        }
    }
}
