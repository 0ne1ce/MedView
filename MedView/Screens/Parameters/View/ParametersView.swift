//
//  ParametersView.swift
//  MedView
//
//  Created by Алексей on 02.02.2025.
//

import Foundation
import UIKit

final class ParametersView: UIView {
    // MARK: - Properties
    let tableView: UITableView = UITableView()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prvate functions
    private func configureUI() {
        backgroundColor = UIColor().hexToRGB(hex: Constants.backgroundLightHex)
    }
    
}
