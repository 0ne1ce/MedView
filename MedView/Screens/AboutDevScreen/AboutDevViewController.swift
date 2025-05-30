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
        static let authorInfoOffsetH: CGFloat = 100
        static let authorInfoOffsetTop: CGFloat = 20
        
        static let hseImageHeight: CGFloat = 100
        static let hseImageOffsetBottom: CGFloat = 20
        static let hseImageOffsetH: CGFloat = 100
    }
    
    // MARK: - Properties
    var interactor: AboutDevBuisnessLogic
    var router: AboutDevRouterProtocol
    
    private let hseMapView: MKMapView = MKMapView()
    private let authorInfoLabel: UILabel = UILabel()
    private let hseImageView: UIImageView = UIImageView()
    
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
        view.backgroundColor = viewModel.backgroundColor
        view.addSubview(hseMapView)
        hseMapView.setRegion(viewModel.hseLocationRegion, animated: true)
        hseMapView.addAnnotation(viewModel.hseAnnotation)
        hseMapView.pinHorizontal(to: view)
        hseMapView.pinVertical(to: view, Constants.hseMapViewOffsetV)
        
        view.addSubview(authorInfoLabel)
        authorInfoLabel.pinHorizontal(to: view, Constants.authorInfoOffsetH)
        authorInfoLabel.pinTop(to: hseMapView.bottomAnchor, Constants.authorInfoOffsetTop)
        authorInfoLabel.text = viewModel.hseAuthor
        authorInfoLabel.textColor = .textPrimary
        authorInfoLabel.font = viewModel.infoFont
        authorInfoLabel.textAlignment = .center
        
        view.addSubview(hseImageView)
        hseImageView.image = viewModel.hseImage
        hseImageView.setHeight(Constants.hseImageHeight)
        hseImageView.pinHorizontal(to: view, Constants.hseImageOffsetH)
        hseImageView.pinBottom(to: hseMapView.topAnchor, Constants.hseImageOffsetBottom)
    }
    
}
