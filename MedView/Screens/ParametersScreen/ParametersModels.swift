//
//  ParametersModels.swift
//  MedView
//
//  Created by Алексей on 11.02.2025.
//

import Foundation
import UIKit

enum ParametersModels {
    
    enum FetchNavigationBar {
        struct Request {
            
        }
        struct Response {
            var titleText: NSMutableAttributedString
        }
        struct ViewModel {
            var title: UILabel
            var settingsButton: UIButton
            var backgroundColor: UIColor
            var borderline: UIView
        }
    }
    enum FetchParameters {
        struct Request {
            
        }
        struct Response {
            var tableTitleText: String
        }
        struct ViewModel {
            var tableView: UITableView
            var tableTitle: UILabel
        }
    } 
}
