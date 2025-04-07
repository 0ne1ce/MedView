//
//  AboutDevViewController.swift
//  MedView
//
//  Created by Алексей on 23.03.2025.
//

import Foundation
import UIKit
import MapKit

final class AboutDevViewController: UIViewController, AboutDevDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let hseMapViewOffsetV: CGFloat = 150
    }
    
    // MARK: - Properties
    var interactor: AboutDevBuisnessLogic
    var router: AboutDevRouterProtocol
    
    private let hseMapView: MKMapView = MKMapView()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStart()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = AboutDevModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AboutDevModels.LoadStart.ViewModel) {
        view.backgroundColor = UIColor(hex: viewModel.backgroundColorHex)
        view.addSubview(hseMapView)
        hseMapView.setRegion(viewModel.hseLocationRegion, animated: true)
        hseMapView.addAnnotation(viewModel.hseAnnotation)
        hseMapView.pinHorizontal(to: view)
        hseMapView.pinVertical(to: view, Constants.hseMapViewOffsetV)
    }
    
}
