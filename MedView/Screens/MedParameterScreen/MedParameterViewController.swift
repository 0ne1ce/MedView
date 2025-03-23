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
        
    }
    
    // MARK: - Properties
    var interactor: MedParameterBuisnessLogic
    var router: MedParameterRouterProtocol
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = MedParameterModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.backgroundColor = UIColor(hex: viewModel.backgroundColorHex)
    }
    
}
