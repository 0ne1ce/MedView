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
        static let navigationBarHeight: CGFloat = 120
        static let guideTextFontSize: CGFloat = 24
        static let guideTextLimit: Int = 0
        static let guideTextFont = UIFont.systemFont(ofSize: 24)
        
        static let animationSize: CGFloat = 30
        static let animationOffsetRight: CGFloat = 20
        static let animationOffsetTop: CGFloat = 5
        
        static let heightForRow: CGFloat = 30
        
        static let onboardingButtonOffsetBottom: CGFloat = 100
        static let onboardingButtonOffsetH: CGFloat = 115
        static let onboardingButtonWidth: CGFloat = 170
        static let onboardingButtonHeight: CGFloat = 45
        static let onboardingButtonRadius: CGFloat = 15
        static let onboardingButtonShadowRadius: CGFloat = 2
        static let onboardingButtonShadowOpacity: Float = 0.5
        static let onboardingButtonShadowHeight: CGFloat = 2
        
        static let onboardingTitleLabelOffsetLeft: CGFloat = 20
        
        static let questionsTableOffsetBottom: CGFloat = 10
    }
    
    // MARK: - Properties
    var interactor: HelpBuisnessLogic
    var router: HelpRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    var questionsAnswersTable: UITableView = UITableView()
    var onboardingButton: UIButton = UIButton(type: .system)
    
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
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadStart()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = HelpModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: HelpModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel)
        configureSettingsButtonTarget()
        
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        configureOnboardingButton(with: viewModel)
        configureTableView(with: viewModel)
        configureAnimation(with: viewModel)
    }
    
    func displaySettings(viewModel: HelpModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = .backgroundPrimary
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.buttonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func configureOnboardingButton(with viewModel: HelpModels.LoadStart.ViewModel) {
        view.addSubview(onboardingButton)
        onboardingButton.setHeight(Constants.onboardingButtonHeight)
        onboardingButton.pinBottom(to: view.bottomAnchor, Constants.onboardingButtonOffsetBottom)
        onboardingButton.pinHorizontal(to: view, Constants.onboardingButtonOffsetH)
        
        onboardingButton.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        guard let titleLabel = onboardingButton.titleLabel else { return }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: onboardingButton.leadingAnchor, constant: Constants.onboardingTitleLabelOffsetLeft),
            titleLabel.centerYAnchor.constraint(equalTo: onboardingButton.centerYAnchor)
        ])
        onboardingButton.setTitle(viewModel.onboardingButtonText, for: .normal)
        onboardingButton.tintColor = viewModel.onboardingButtonTextColor
        onboardingButton.titleLabel?.font = viewModel.onboardingButtonTextFont
        onboardingButton.titleLabel?.textAlignment = .left
        onboardingButton.backgroundColor = viewModel.onboardingButtonColor
        
        onboardingButton.layer.cornerRadius = Constants.onboardingButtonRadius
        onboardingButton.layer.shadowColor = viewModel.onboardingButtonBoundsColor.cgColor
        onboardingButton.layer.shadowOffset = CGSize(
            width: .zero,
            height: Constants.onboardingButtonShadowHeight
        )
        onboardingButton.layer.shadowOpacity = Constants.onboardingButtonShadowOpacity
        onboardingButton.layer.shadowRadius = Constants.onboardingButtonShadowRadius
    }
    
    private func configureTableView(with viewModel: HelpModels.LoadStart.ViewModel) {
        view.addSubview(questionsAnswersTable)
        questionsAnswersTable.pinHorizontal(to: view)
        questionsAnswersTable.pinTop(to: navigationBar.bottomAnchor)
        questionsAnswersTable.pinBottom(to: onboardingButton.topAnchor, Constants.questionsTableOffsetBottom)
        
        questionsAnswersTable.register(AssistantMessageCell.self, forCellReuseIdentifier: AssistantMessageCell.reuseId)
        questionsAnswersTable.register(UserMessageCell.self, forCellReuseIdentifier: UserMessageCell.reuseId)
        
        questionsAnswersTable.delegate = self
        questionsAnswersTable.dataSource = interactor
        
        questionsAnswersTable.backgroundColor = viewModel.tableBackgroundColor
        questionsAnswersTable.separatorStyle = .none
        questionsAnswersTable.estimatedRowHeight = Constants.heightForRow
    }
    
    private func configureAnimation(with viewModel: HelpModels.LoadStart.ViewModel) {
        let animationView = LottieAnimationView(name: viewModel.animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .autoReverse
        animationView.play()
        onboardingButton.addSubview(animationView)
        animationView.pinRight(to: onboardingButton.trailingAnchor, Constants.animationOffsetRight)
        animationView.pinTop(to: onboardingButton.topAnchor, Constants.animationOffsetTop)
        animationView.setWidth(Constants.animationSize)
        animationView.setHeight(Constants.animationSize)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = HelpModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
}

// MARK: - UITableViewDelegate
extension HelpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
    }
}
