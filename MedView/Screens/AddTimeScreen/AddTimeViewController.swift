//
//  AboutDevViewController.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit
import MapKit

final class AddTimeViewController: UIViewController, AddTimeDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let hseMapViewOffsetV: CGFloat = 150
        static let authorInfoOffsetH: CGFloat = 100
        static let authorInfoOffsetTop: CGFloat = 20
        
        static let hseImageHeight: CGFloat = 100
        static let hseImageOffsetBottom: CGFloat = 20
        static let hseImageOffsetH: CGFloat = 100
    }
    
    // MARK: - Properties
    var interactor: AddTimeBuisnessLogic
    var router: AddTimeRouterProtocol
    
    private let hseMapView: MKMapView = MKMapView()
    private let authorInfoLabel: UILabel = UILabel()
    private let hseImageView: UIImageView = UIImageView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    // MARK: - Initialization
    init(interactor: AddTimeBuisnessLogic, router: AddTimeRouterProtocol) {
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
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = AddTimeModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AddTimeModels.LoadStart.ViewModel) {
        view.backgroundColor = viewModel.backgroundColor
    }
    
    // MARK: - Private functions
    private func configure() {
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonPressed)
        )
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Actions
    @objc private func cancelButtonPressed() {
        dismiss(animated: true)
    }

}
