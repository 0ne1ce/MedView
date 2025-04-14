//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class CardViewController: UIViewController, CardDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let navigationBarHeight: CGFloat = 155
        
        static let cardTableOffsetTop: CGFloat = 10
        static let cardTableOffsetHorizontal: CGFloat = 10
        static let cardTableRadius: CGFloat = 10
        
        static let heightForRow: CGFloat = 45
    }
    
    // MARK: - Properties
    var interactor: CardBuisnessLogic
    var router: CardRouterProtocol
    var navigationBar: CustomNavigationBarView = CustomNavigationBarView()
    let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    var cardTable: UITableView = UITableView()
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }()
    
    // MARK: - Initialization
    init(interactor: CardBuisnessLogic, router: CardRouterProtocol) {
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
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = CardModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: CardModels.LoadStart.ViewModel) {
        navigationBar.configure(with: viewModel, true)
        view.addSubview(navigationBar)
        
        navigationBar.pinTop(to: view)
        navigationBar.setHeight(Constants.navigationBarHeight)
        navigationBar.pinLeft(to: view)
        navigationBar.pinRight(to: view)
        configureCardTable()
    }
    
    func displayTextFieldValue(viewModel: CardModels.SaveValue.ViewModel) {
        
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = .backgroundPrimary
        configureNavigationItems()
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.numberOfTapsRequired = 1
    }
    
    private func configureNavigationItems() {
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .main
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.main]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureCardTable() {
        cardTable.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseId)
        cardTable.delegate = self
        cardTable.dataSource = interactor
        
        cardTable.backgroundColor = .clear
        cardTable.separatorStyle = .singleLine
        cardTable.allowsSelection = false
        cardTable.isScrollEnabled = false
        
        view.addSubview(cardTable)
        cardTable.pinHorizontal(to: view, Constants.cardTableOffsetHorizontal)
        cardTable.pinBottom(to: view)
        cardTable.pinTop(to: navigationBar.bottomAnchor, Constants.cardTableOffsetTop)
        cardTable.layer.cornerRadius = Constants.cardTableRadius
    }
    
    // MARK: - Actions
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
}

// MARK: - UITableViewDelegate
extension CardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CardCell {
            cell.valueTextField.delegate = self
            cell.valueTextField.tag = indexPath.row
        }
    }
}

// MARK: - UITextFieldDelegate
extension CardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let request = CardModels.SaveValue.Request(
            parameterTag: textField.tag,
            value: textField.text ?? ""
        )
        interactor.saveTextFieldValue(request: request)
    }
}
