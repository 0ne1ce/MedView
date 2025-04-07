//
//  MedParameterViewController.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import Foundation
import UIKit

final class MedParameterViewController: UIViewController, MedParameterDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let mainColorHex: String = "00C7C0"
        static let parameterColorHex: String = "5856D6"
        static let dataPoints: [Double] = [80, 80.8, 80.1, 80.5, 80.8, 81.0, 81.3]
        
        static let graphOffsetH: CGFloat = 30
        static let graphOffsetV: CGFloat = 300
    }
    
    // MARK: - Properties
    var interactor: MedParameterBuisnessLogic
    var router: MedParameterRouterProtocol
    
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    // MARK: - Initialization
    init(interactor: MedParameterBuisnessLogic, router: MedParameterRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStart()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = MedParameterModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.backgroundColor = UIColor(hex: viewModel.backgroundColorHex)
        
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = UIColor(hex: Constants.mainColorHex)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(hex: Constants.mainColorHex)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
