//
//  AssistantViewController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantViewController: UIViewController, AssistantDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let backgroundLightHex: String = "F2F2F7"
        
        static let navigationBarHeight: CGFloat = 120
        
        static let inputWrapHeight: CGFloat = 50
        static let inputWrapOffsetH: CGFloat = 15
        static let inputWrapBottomOffset: CGFloat = 10
        static let inputWrapCornerRadius: CGFloat = 20
        
        static let inputTextViewOffsetLeft: CGFloat = 20
        static let inputTextViewOffsetRight: CGFloat = 50
        static let inputTextViewRightOffsetAnimated: CGFloat = 50
        static let inputTextViewOffsetTop: CGFloat = 7
        static let inputTextViewOffsetBottom: CGFloat = 10
        
        static let wrapAppearanceAnimationTime: Double = 0.4
        
        static let sendButtonWidth: CGFloat = 50
        static let sendButtonCornerRadius: CGFloat = 20
        
        static let heightForRow: CGFloat = 30
        
        static let placeholderText: String = "Request"
    }
    
    // MARK: - Properties
    var interactor: AssistantBuisnessLogic
    var router: AssistantRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    
    // MARK: - Variables
    var inputWrap: UIView = UIView()
    var inputTextView: UITextView = UITextView()
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }()
    var sendButton: UIButton = UIButton(type: .custom)
    var tableView: UITableView = UITableView()
    
    // MARK: - Initialization
    init(interactor: AssistantBuisnessLogic, router: AssistantRouterProtocol) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: Constants.wrapAppearanceAnimationTime,
            animations: {[self] in
                wrapAnimated()
            },
            completion: {
                [weak self] _ in
                self?.sendButton.isEnabled = true
            }
        )
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = AssistantModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: AssistantModels.LoadStart.ViewModel) {
        navigationBar.confiugre(with: viewModel)
        configureSettingsButtonTarget()
        
        view.addSubview(navigationBar)
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        
        configureInputWrap(with: viewModel)
        configureInputTextView(with: viewModel)
        configureSendButton(with: viewModel)
        configureTableView(with: viewModel)
    }
    
    func displaySettings(viewModel: AssistantModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    func displayMessage(viewModel: AssistantModels.SendUserMessage.ViewModel) {
        tableView.reloadData()
        inputTextView.text = viewModel.placeholderText
        inputTextView.textColor = viewModel.placeholderColor
    }
    
    func displayAssistantMessage(viewModel: AssistantModels.SendAssistantMessage.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = UIColor(hex: Constants.backgroundLightHex)
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.numberOfTapsRequired = 1
    }
    
    private func configureSettingsButtonTarget() {
        navigationBar.settingsButtonTarget(target: self, action: #selector(settingsButtonPressed))
    }
    
    private func configureInputWrap(with viewModel: AssistantModels.LoadStart.ViewModel) {
        view.addSubview(inputWrap)
        inputWrap.pinLeft(to: view, Constants.inputWrapOffsetH)
        inputWrap.setWidth(Constants.sendButtonWidth)
        inputWrap.pinBottom(to: view.keyboardLayoutGuide.topAnchor, Constants.inputWrapBottomOffset)
        inputWrap.setHeight(Constants.inputWrapHeight)
        
        inputWrap.layer.cornerRadius = Constants.inputWrapCornerRadius
        inputWrap.backgroundColor = viewModel.inputWrapBackgroundColor
    }
    
    private func configureInputTextView(with viewModel: AssistantModels.LoadStart.ViewModel) {
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputWrap.addSubview(inputTextView)
        inputTextView.pinLeft(to: inputWrap, Constants.inputTextViewOffsetLeft)
        inputTextView.pinRight(to: inputWrap, Constants.inputTextViewOffsetRight)
        inputTextView.pinTop(to: inputWrap, Constants.inputTextViewOffsetTop)
        inputTextView.pinBottom(to: inputWrap, Constants.inputTextViewOffsetBottom)
        
        inputTextView.text = viewModel.placeholderText
        inputTextView.textColor = viewModel.placeholderColor
        inputTextView.font = viewModel.placeholderFont
        inputTextView.isScrollEnabled = true
        inputTextView.textContainer.maximumNumberOfLines = .zero
        inputTextView.textContainer.lineBreakMode = .byWordWrapping
        inputTextView.backgroundColor = viewModel.inputWrapBackgroundColor
        
        inputTextView.delegate = self
    }
    
    private func configureSendButton(with viewModel: AssistantModels.LoadStart.ViewModel) {
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
    
    private func configureTableView(with viewModel: AssistantModels.LoadStart.ViewModel) {
        view.addSubview(tableView)
        tableView.pinHorizontal(to: view)
        tableView.pinTop(to: navigationBar.bottomAnchor)
        tableView.pinBottom(to: inputWrap.topAnchor)
        
        tableView.register(AssistantMessageCell.self, forCellReuseIdentifier: AssistantMessageCell.reuseId)
        tableView.register(UserMessageCell.self, forCellReuseIdentifier: UserMessageCell.reuseId)
        
        tableView.backgroundColor = viewModel.tableBackgroundColor
        tableView.delegate = self
        tableView.dataSource = interactor
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = Constants.heightForRow
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    private func wrapAnimated() {
        inputWrap.pinRight(to: view, Constants.inputWrapOffsetH)
        
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = AssistantModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
    
    @objc func sendButtonPressed() {
        triggerSelectionFeedback()
        guard let inputTextMessage = inputTextView.text, !inputTextView.text.isEmpty, inputTextView.textColor != .lightGray else {
            return
        }
        let userMessageRequest = AssistantModels.SendUserMessage.Request(userMessageText: inputTextMessage)
        inputTextView.isEditable = false
        inputTextView.isEditable = true
        interactor.sendMessage(request: userMessageRequest)
        
        let assistantMessageRequest = AssistantModels.SendAssistantMessage.Request(userMessageText: inputTextMessage)
        Task {
            await interactor.sendAssistantMessage(request: assistantMessageRequest)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            inputTextView.isEditable = false
            inputTextView.isEditable = true
        }
    }
}

// MARK: - UITextViewDelegate
extension AssistantViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.placeholderText
            textView.textColor = .lightGray
            textView.resignFirstResponder()
        }
    }
}

// MARK: - UITableViewDelegate
extension AssistantViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        triggerSelectionFeedback()
    }
}
