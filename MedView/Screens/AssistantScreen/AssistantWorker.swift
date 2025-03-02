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
    private var client: OpenAISwift = OpenAISwift(
        config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: APIKey.get())
    )
    
    var response: String = ""
    
    init() {}
    
    func getResponse(input: String) async {
        let chatArr = [ChatMessage(role: .system, content: "You are a helpful assistant."), ChatMessage(role: .user, content: input)]
        do {
            let results = try await client.sendChat(
                with: chatArr,
                model: .gpt4o(.gpt4oMini),
                maxTokens: 100
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
