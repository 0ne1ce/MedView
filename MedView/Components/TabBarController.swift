//
//  TabBarController.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Constants
    private enum Constants {
        static let mainColorHex: String = "00C7C0"
        
        static let parametersTabTitle: String = "Data"
        static let parametersTabImage: UIImage? = UIImage(systemName: "heart.text.square")
        
        static let assistantTabTitle: String = "Assistant"
        static let assistantTabImage: UIImage? = UIImage(systemName: "stethoscope")
        
        static let helpTabTitle: String = "Help"
        static let helpTabImage: UIImage? = UIImage(systemName: "questionmark.circle")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureTabs()
        configureUI()
    }
    
    //MARK: - Private functions
    private func configureTabs() {
        let parametersController = ParametersAssembly.build()
        let assistantController = AssistantAssembly.build()
        let helpController = HelpAssembly.build()
        
        let data = self.createNav(for: parametersController, with: Constants.parametersTabTitle, Constants.parametersTabImage)
        let assistant = self.createNav(for: assistantController, with: Constants.assistantTabTitle, Constants.assistantTabImage)
        let help = self.createNav(for: helpController, with: Constants.helpTabTitle, Constants.helpTabImage)
        self.setViewControllers([data, assistant, help], animated: true)
    }
    
    private func createNav(for viewController: UIViewController, with title: String, _ image: UIImage?) -> UINavigationController
    {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func configureUI() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor(hex: Constants.mainColorHex)
    }
    
    private func triggerSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // MARK: - Public functions
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        triggerSelectionFeedback()
    }
    
}
