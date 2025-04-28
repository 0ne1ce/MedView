//
//  AssistantWorker.swift
//  MedView
//
//  Created by Алексей on 06.02.2025.
//

import Foundation

final class AssistantWorker {
    // MARK: - Constants
    private enum Constants {
        static let promptContent: String = """
        You are a helpful medical assistant and you can only answer medical or healthy lifestyle questions. Avoid political or programming questions.
        """
        static let modelName: String = "open-mistral-nemo"
        static let chatCompletionURL: String = "https://api.mistral.ai/v1/chat/completions"
        static let apiKey = APIKey.get()
    }
    
    // MARK: - Variables
    var response: String = ""
    
    // MARK: - Public functions
    func getResponse(input: String, data: [ChartDataPoint]) async {
        var fullPrompt = ""
        
        if data.isEmpty {
            fullPrompt = """
            \(Constants.promptContent)
            Question: \(input)
            """
        } else {
            let dataDescription = data.map { $0.description }.joined(separator: ", ")

            fullPrompt = """
            \(Constants.promptContent)
            Question: \(input)
            Data points for context: \(dataDescription)
            """
        }

        guard let url = URL(string: Constants.chatCompletionURL) else {
            print("Invalid URL")
            response = "Sorry, I couldn't process your request."
            return
        }

        let body: [String: Any] = [
            "model": Constants.modelName,
            "messages": [
                [
                    "role": "user",
                    "content": fullPrompt
                ]
            ]
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            
            let (data, _) = try await URLSession.shared.data(for: request)

            let decodedResponse = try JSONDecoder().decode(MistralResponse.self, from: data)

            if let content = decodedResponse.choices.first?.message.content {
                self.response = content.trimmingCharacters(in: .whitespacesAndNewlines)
                self.response = self.response.replacingOccurrences(of: "**", with: "")
            } else {
                print("No content in response")
                response = "Sorry, I couldn't process your request."
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            response = "Sorry, I couldn't process your request."
        }
    }
}

struct MistralResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
}

struct Choice: Decodable {
    let index: Int
    let message: Message
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case finishReason = "finish_reason"
    }
}

struct Message: Decodable {
    let role: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}
