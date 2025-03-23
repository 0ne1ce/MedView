//
//  AssistantInteractor.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit

final class AssistantInteractor: NSObject, AssistantBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let assistantLabelText: NSMutableAttributedString = NSMutableAttributedString("Assistant")
        static let settingsImageName: String = "SettingsSymbol"
        static let placeholderText: String = "Request"
        
        static let numberOfSections: Int = 2
        static let firstMessageCount: Int = 1
        
        static let animationName: String = "HealthLoadAnimation"
    }
    
    // MARK: - MessageRoles
    private enum MessageRole {
        case user
        case assistant
    }
    
    private struct Message {
        let role: MessageRole
        let messageText: String
    }
    
    // MARK: - Properties
    var presenter: AssistantPresentationLogic
    var worker: AssistantWorker
    
    // MARK: - Variables
    private var messages: [Message] = []
    
    // MARK: - Initialization
    init(presenter: AssistantPresentationLogic, worker: AssistantWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Functions
    func loadStart(request: AssistantModels.LoadStart.Request) {
        let response = AssistantModels.LoadStart.Response(
            titleText: Constants.assistantLabelText,
            settingsImageName: Constants.settingsImageName,
            placeholderText: Constants.placeholderText,
            animationName: Constants.animationName
        )
        presenter.presentStart(response: response)
    }
    
    func loadSettings(request: AssistantModels.LoadSettings.Request) {
        let response = AssistantModels.LoadSettings.Response()
        presenter.presentSettings(response: response)
    }
    
    func sendMessage(request: AssistantModels.SendUserMessage.Request) {
        messages.append(Message(role: .user, messageText: request.userMessageText))
        let response = AssistantModels.SendUserMessage.Response(placeholderText: Constants.placeholderText)
        presenter.presentUserMessage(response: response)
    }
    
    func sendAssistantMessage(request: AssistantModels.SendAssistantMessage.Request) async {
        await worker.getResponse(input: request.userMessageText)
        if (worker.response != "") {
            messages.append(Message(role: .assistant, messageText: worker.response))
        }
        let response = AssistantModels.SendAssistantMessage.Response()
        presenter.presentAssistantMessage(response: response)
    }
}

// MARK: - UITableViewDataSource
extension AssistantInteractor: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.firstMessageCount
        default:
            return messages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AssistantMessageCell.reuseId, for: indexPath)
            guard let messageCell = cell as? AssistantMessageCell else {
                return cell
            }
            messageCell.configure(with: "Hello, how can I help you today?")
            return cell
        default:
            switch messages[indexPath.row].role {
            case .user:
                let cell = tableView.dequeueReusableCell(withIdentifier: UserMessageCell.reuseId, for: indexPath)
                guard let messageCell = cell as? UserMessageCell else {
                    return cell
                }
                messageCell.configure(with: messages[indexPath.row].messageText)
                return cell
            case .assistant:
                let cell = tableView.dequeueReusableCell(withIdentifier: AssistantMessageCell.reuseId, for: indexPath)
                guard let messageCell = cell as? AssistantMessageCell else {
                    return cell
                }
                messageCell.configure(with: messages[indexPath.row].messageText)
                return cell
            }
            
        }
    }
}
