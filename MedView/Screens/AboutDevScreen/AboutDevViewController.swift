//
//  AboutDevViewController.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit

final class AboutDevViewController: UIViewController, AboutDevDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Properties
    var interactor: AboutDevBuisnessLogic
    var router: AboutDevRouterProtocol
    
    // MARK: - Initialization
    init(interactor: AboutDevBuisnessLogic, router: AboutDevRouterProtocol) {
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
        let request = AboutDevModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AboutDevModels.LoadStart.ViewModel) {
        view.backgroundColor = UIColor(hex: viewModel.backgroundColorHex)
    }
    
}
