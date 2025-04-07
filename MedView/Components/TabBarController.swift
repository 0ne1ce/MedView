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
        static let parametersTabImageSelected: UIImage? = UIImage(systemName: "heart.text.square.fill")
        
        static let assistantTabTitle: String = "Assistant"
        static let assistantTabImage: UIImage? = UIImage(systemName: "stethoscope.circle")
        static let assistantTabImageSelected: UIImage? = UIImage(systemName: "stethoscope.circle.fill")
        
        static let helpTabTitle: String = "Help"
        static let helpTabImage: UIImage? = UIImage(systemName: "questionmark.circle")
        static let helpTabImageSelected: UIImage? = UIImage(systemName: "questionmark.circle.fill")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureTabs()
        configureUI()
    }
    
    // MARK: - Private functions
    private func configureTabs() {
        let parametersController = UINavigationController(rootViewController: ParametersAssembly.build())
        let assistantController = UINavigationController(rootViewController: AssistantAssembly.build())
        let helpController = UINavigationController(rootViewController: HelpAssembly.build())
        
        parametersController.tabBarItem = UITabBarItem(
            title: Constants.parametersTabTitle,
            image: Constants.parametersTabImage,
            selectedImage: Constants.parametersTabImageSelected
        )
        assistantController.tabBarItem = UITabBarItem(
            title: Constants.assistantTabTitle,
            image: Constants.assistantTabImage,
            selectedImage: Constants.assistantTabImageSelected
        )
        helpController.tabBarItem = UITabBarItem(
            title: Constants.helpTabTitle,
            image: Constants.helpTabImage,
            selectedImage: Constants.helpTabImageSelected
        )
        
        self.setViewControllers([parametersController, assistantController, helpController], animated: true)
    }
    
    private func createNav(for viewController: UIViewController, with title: String, _ image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func configureUI() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor(hex: Constants.mainColorHex)
        tabBar.clipsToBounds = true
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
