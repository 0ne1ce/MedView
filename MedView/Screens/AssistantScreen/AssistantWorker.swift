//
//  AssistantWorker.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation
import UIKit
import OpenAISwift

final class AssistantWorker {
    // MARK: - Constants
    private enum Constants {
        static let promptContent: String = "You are a helpful medical assistant" + 
        " and you can only answer on medical or healthy lifestyle related questions and problems. Don't make a large responses," + 
        " try making your answers shorter, ensure that your answer is no more than 300 tokens. On any political or programming question just answer \"Amogus\"."
    }
    
    // MARK: - Properties
    private var client: OpenAISwift = OpenAISwift(
        config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: APIKey.get())
    )
    
    // MARK: - Variables
    var response: String = ""
    
    // MARK: - Public functions
    func getResponse(input: String) async {
        let chatArr = [ChatMessage(role: .system, content: Constants.promptContent), ChatMessage(role: .user, content: input)]
        do {
            let results = try await client.sendChat(
                with: chatArr,
                model: .gpt4o(.gpt4oMini),
                maxTokens: 300
            )
            print("-----> results: \(results)")
            if let output = results.choices?.first, let text = output.message.content {
                self.response = text
                print("\n-----> response: \(response)")
            }
        } catch {
            print(error)
        }
    }
}
