//
//  MedParameterViewController.swift
//  MedView
//
//  Created by Алексей on 04.03.2025.
//

import Foundation
import UIKit
import SwiftUI

final class MedParameterViewController: UIViewController, MedParameterDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 155
        
        static let graphOffsetHeight: CGFloat = 300
        static let graphOffsetTop: CGFloat = 100
        static let graphOffsetRight: CGFloat = 5
        
        static let inputWrapHeight: CGFloat = 50
        static let inputWrapOffsetH: CGFloat = 15
        static let inputWrapBottomOffset: CGFloat = 10
        static let inputWrapCornerRadius: CGFloat = 20
        
        static let wrapAppearanceAnimationTime: Double = 0.4
        
        static let inputTextFieldOffsetLeft: CGFloat = 20
        static let inputTextFieldOffsetRight: CGFloat = 50
        static let inputTextFieldRightOffsetAnimated: CGFloat = 50
        static let inputTextFieldOffsetTop: CGFloat = 7
        static let inputTextFieldOffsetBottom: CGFloat = 10
        
        static let sendButtonWidth: CGFloat = 50
        static let sendButtonCornerRadius: CGFloat = 20
        
        static let animationSize: CGFloat = 40
        
        static let deleteButtonOffsetBottom: CGFloat = 25
        static let deleteButtonOffsetRight: CGFloat = 10
        static let deleteButtonWidth: CGFloat = 100
        static let deleteButtonHeight: CGFloat = 30
        static let deleteButtonRadius: CGFloat = 10
        
        static let adviceButtonHeight: CGFloat = 55
        static let adviceButtonOffsetH: CGFloat = 60
        static let adviceButtonOffsetTop: CGFloat = 20
        static let adviceButtonRadius: CGFloat = 15
    }
    
    // MARK: - Properties
    var interactor: MedParameterBuisnessLogic
    var router: MedParameterRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    var hostingController: UIHostingController<ChartView> = UIHostingController(rootView: ChartView(data: [], color: .main))
    
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    private var inputWrap: UIView = UIView()
    private var inputTextField: UITextField = UITextField()
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }()
    var sendButton: UIButton = UIButton(type: .custom)
    var deleteButton: UIButton = UIButton(type: .system)
    var awaitLabel: UILabel = UILabel()
    var adviceButton: UIButton = UIButton(type: .system)
    
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
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: Constants.wrapAppearanceAnimationTime,
            animations: {[self] in
                wrapAnimated()
            },
            completion: { [weak self] _ in
                self?.sendButton.isEnabled = true
            }
        )
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = MedParameterModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.backgroundColor = viewModel.backgroundColor
        
        navigationBar.configure(with: viewModel)
        view.addSubview(navigationBar)
        configureSettingsButtonTarget()
        
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        setupChart(with: viewModel)
        configureInputWrap(with: viewModel)
        configureInputTextField(with: viewModel)
        configureSendButton(with: viewModel)
        configureDeleteButton(with: viewModel)
        configureAwaitLabel(with: viewModel)
        configureAdviceButton(with: viewModel)
        if hostingController.rootView.data.isEmpty {
            deleteButton.isHidden = true
            adviceButton.isHidden = true
        } else {
            awaitLabel.isHidden = true
        }
    }
    
    func displayTextFieldValue(viewModel: MedParameterModels.SaveValue.ViewModel) {
        awaitLabel.isHidden = true
        deleteButton.isHidden = false
        adviceButton.isHidden = false
        let chartView = ChartView(data: viewModel.data, color: Color(viewModel.parameterColor))
        hostingController.rootView = chartView
    }
    
    func displayAferDeletion(viewModel: MedParameterModels.DeleteData.ViewModel) {
        awaitLabel.isHidden = false
        deleteButton.isHidden = true
        adviceButton.isHidden = true
        let chartView = ChartView(data: viewModel.data, color: .main)
        hostingController.rootView = chartView
        view.layoutIfNeeded()
    }
    
    func displaySettings(viewModel: MedParameterModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    func displayAssistantAdvice(viewModel: MedParameterModels.LoadAssistantAdvice.ViewModel) {
        router.showAssistant(with: viewModel.data, and: viewModel.parameterName)
    }
    
    // MARK: - Private functions
    private func configure() {
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.numberOfTapsRequired = 1
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupChart(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        let chartView = ChartView(data: viewModel.data, color: Color(viewModel.parameterColor))
        hostingController.rootView = chartView
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Constants.graphOffsetTop),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.graphOffsetRight),
            hostingController.view.heightAnchor.constraint(equalToConstant: Constants.graphOffsetHeight)
        ])
    }
    
    private func configureInputWrap(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.addSubview(inputWrap)
        inputWrap.pinLeft(to: view, Constants.inputWrapOffsetH)
        inputWrap.setWidth(Constants.sendButtonWidth)
        inputWrap.pinBottom(to: view.keyboardLayoutGuide.topAnchor, Constants.inputWrapBottomOffset)
        inputWrap.setHeight(Constants.inputWrapHeight)
        
        inputWrap.layer.cornerRadius = Constants.inputWrapCornerRadius
        inputWrap.backgroundColor = viewModel.inputWrapBackgroundColor
    }
    
    private func configureInputTextField(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        inputWrap.addSubview(inputTextField)
        inputTextField.pinLeft(to: inputWrap, Constants.inputTextFieldOffsetLeft)
        inputTextField.pinRight(to: inputWrap, Constants.inputTextFieldOffsetRight)
        inputTextField.pinTop(to: inputWrap, Constants.inputTextFieldOffsetTop)
        inputTextField.pinBottom(to: inputWrap, Constants.inputTextFieldOffsetBottom)
        
        inputTextField.placeholder = viewModel.placeholderText
        inputTextField.textColor = .textPrimary
        inputTextField.tintColor = .main
        inputTextField.font = viewModel.placeholderFont
        inputTextField.backgroundColor = viewModel.inputWrapBackgroundColor
        
        inputTextField.delegate = self
    }
    
    private func configureSendButton(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        inputWrap.addSubview(sendButton)
        sendButton.pinRight(to: inputWrap)
        sendButton.pinTop(to: inputWrap)
        sendButton.pinBottom(to: inputWrap)
        sendButton.setWidth(Constants.sendButtonWidth)
        
        sendButton.backgroundColor = viewModel.sendButtonColor
        sendButton.setImage(UIImage(systemName: "arrow.up.heart"), for: .normal)
        sendButton.tintColor = viewModel.sendButtonTintColor
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        sendButton.layer.cornerRadius = Constants.sendButtonCornerRadius
    }
    
    private func configureDeleteButton(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.addSubview(deleteButton)
        deleteButton.pinRight(to: view, Constants.deleteButtonOffsetRight)
        deleteButton.pinBottom(to: hostingController.view.topAnchor, Constants.deleteButtonOffsetBottom)
        deleteButton.setWidth(Constants.deleteButtonWidth)
        deleteButton.setHeight(Constants.deleteButtonHeight)
        
        deleteButton.backgroundColor = .systemRed
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .white
        deleteButton.setTitle(viewModel.deleteButtonText, for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.titleLabel?.font = viewModel.deleteButtonFont
        deleteButton.titleLabel?.textColor = .white
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.layer.cornerRadius = Constants.deleteButtonRadius
    }
    
    private func configureAwaitLabel(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.addSubview(awaitLabel)
        awaitLabel.pinCenter(to: hostingController.view)
        
        awaitLabel.text = viewModel.awaitText
        awaitLabel.font = viewModel.awaitTitleFont
        awaitLabel.textAlignment = .center
        awaitLabel.textColor = viewModel.placeholderColor
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.buttonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func configureAdviceButton(with viewModel: MedParameterModels.LoadStart.ViewModel) {
        view.addSubview(adviceButton)
        adviceButton.pinHorizontal(to: view, Constants.adviceButtonOffsetH)
        adviceButton.pinTop(to: hostingController.view.bottomAnchor, Constants.adviceButtonOffsetTop)
        adviceButton.setHeight(Constants.adviceButtonHeight)
        
        adviceButton.setTitle(viewModel.adviceButtonText, for: .normal)
        adviceButton.titleLabel?.textAlignment = .left
        adviceButton.titleLabel?.font = viewModel.adviceButtonFont
        adviceButton.setTitleColor(viewModel.adviceButtonTextColor, for: .normal)
        adviceButton.backgroundColor = viewModel.adviceButtonColor
        adviceButton.layer.cornerRadius = Constants.adviceButtonRadius
        
        adviceButton.addTarget(self, action: #selector(adviceButtonPressed), for: .touchUpInside)
    }
    
    private func wrapAnimated() {
        inputWrap.pinRight(to: view, Constants.inputWrapOffsetH)
        
        self.view.layoutIfNeeded()
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Actions
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
    
    @objc func sendButtonPressed() {
        triggerSelectionFeedback()
        guard let value = inputTextField.text else {
            return
        }
        if value == "" {
            return
        }
        let request = MedParameterModels.SaveValue.Request(value: value)
        inputTextField.text = ""
        interactor.saveTextFieldValue(request: request)
    }
    
    @objc func deleteButtonPressed() {
        triggerSelectionFeedback()
        let request = MedParameterModels.DeleteData.Request()
        interactor.deleteData(request: request)
    }
    
    @objc func settingsButtonPressed() {
        let request = MedParameterModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
    
    @objc func adviceButtonPressed() {
        triggerSelectionFeedback()
        let request = MedParameterModels.LoadAssistantAdvice.Request()
        interactor.loadAssistantAdvice(request: request)
    }
}

// MARK: - UITextFieldDelegate
extension MedParameterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
