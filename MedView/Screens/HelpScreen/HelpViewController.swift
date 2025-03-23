//
//  HelpViewController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit
import Lottie

final class HelpViewController: UIViewController, HelpDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let navigationBarHeight: CGFloat = 120
        static let guideTextFontSize: CGFloat = 24
        static let guideTextLimit: Int = 0
        static let guideTextFont = UIFont.systemFont(ofSize: 24)
        
        static let animationSize: CGFloat = 200
    }
    
    // MARK: - Properties
    var interactor: HelpBuisnessLogic
    var router: HelpRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Initialization
    init(interactor: HelpBuisnessLogic, router: HelpRouterProtocol) {
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadStart()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = HelpModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: HelpModels.LoadStart.ViewModel) {
        navigationBar.confiugre(with: viewModel)
        configureSettingsButtonTarget()
        
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        let animationView = LottieAnimationView(name: viewModel.animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .autoReverse
        animationView.play()
        view.addSubview(animationView)
        animationView.pinCenter(to: view)
        animationView.setWidth(Constants.animationSize)
        animationView.setHeight(Constants.animationSize)
    }
    
    func displaySettings(viewModel: HelpModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = UIColor(hex: Constants.backgroundLightHex)
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = HelpModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
}
