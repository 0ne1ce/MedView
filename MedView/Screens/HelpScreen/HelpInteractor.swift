//
//  HelpInteractor.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class HelpInteractor: NSObject, HelpBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let questionFirst: String = "What can I do in the Data section?"
        static let answerFirst: String = "View a list of tracked parameters (e.g., heart rate, blood pressure, temperature, etc.)." + 
        " Tap on a parameter to open a graph showing its changes over a selected period."
        static let helpLabelText: NSMutableAttributedString = NSMutableAttributedString("FAQ and guide")
        static let settingsImageName: String = "SettingsSymbol"
        static let animationName: String = "HealthLoadAnimation"
        
        static let numberOfRows: Int = 6
        
        static let onboardingButtonText: String = "Quick Start"
        
        static let firstQuestion: String = "What can I do in the Data section?"
        static let firstAnswer: String = """
        View a list of tracked parameters (e.g., heart rate, blood pressure, temperature, etc.).\n
        Tap on a parameter to open a graph showing its changes over a selected period.
        """
        
        static let secondQuestion: String = "What does the Assistant do?"
        static let secondAnswer: String = """
        Provides personalized tips and recommendations based on the parameters you've entered.\n
        Answers questions about your health, such as: "Why is my stress level increasing?" or "What should I do about high blood pressure?.
        """
        
        static let thirdQuestion: String = "How do I use the Assistant?"
        static let thirdAnswer: String = """
        Go to the Assistant section and start chatting with the model by asking questions.\n
        Recommendations are tailored using your entered parameters and data from the Card section (e.g., blood type, allergies, chronic diseases).
        """
    }
    
    // MARK: - Properties
    var presenter: HelpPresentationLogic
    var worker: HelpWorker
    var questionsAndAnswers: [String] = [
        Constants.firstQuestion,
        Constants.firstAnswer,
        Constants.secondQuestion,
        Constants.secondAnswer,
        Constants.thirdQuestion,
        Constants.thirdAnswer
    ]
    
    // MARK: - Initialization
    init(presenter: HelpPresentationLogic, worker: HelpWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Functions
    func loadStart(request: HelpModels.LoadStart.Request) {
        let response = HelpModels.LoadStart.Response(
            titleText: Constants.helpLabelText,
            settingsImageName: Constants.settingsImageName,
            animationName: Constants.animationName,
            onboardingButtonText: Constants.onboardingButtonText
        )
        presenter.presentStart(response: response)
    }
    
    func loadSettings(request: HelpModels.LoadSettings.Request) {
        let response = HelpModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
}

// MARK: - UITableViewDataSource
extension HelpInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserMessageCell.reuseId, for: indexPath)
            guard let messageCell = cell as? UserMessageCell else {
                return cell
            }
            messageCell.configure(with: questionsAndAnswers[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AssistantMessageCell.reuseId, for: indexPath)
            guard let messageCell = cell as? AssistantMessageCell else {
                return cell
            }
            messageCell.configure(with: questionsAndAnswers[indexPath.row])
            return cell
        }
    }
}
