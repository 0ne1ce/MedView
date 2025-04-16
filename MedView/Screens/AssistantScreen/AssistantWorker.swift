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
        
        static let baseURL = "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.3"
        static let apiKey = APIKey.get()
    }
    
    // MARK: - Variables
    var response: String = ""
    
    // MARK: - Public functions
    func getResponse(input: String) async {
        let prompt = """
        [INST] 
        \(Constants.promptContent)
        Question: \(input)
        [/INST]
        """
        
        do {
            guard let url = URL(string: Constants.baseURL) else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let body: [String: Any] = [
                "inputs": prompt,
                "parameters": [
                    "max_new_tokens": 300,
                    "temperature": 0.7,
                    "return_full_text": false
                ]
            ]
            
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            
            if let firstResponse = json?.first, 
               let generatedText = firstResponse["generated_text"] as? String {
                self.response = generatedText.trimmingCharacters(in: .whitespacesAndNewlines)
                print("Response: \(response)")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            response = "Sorry, I couldn't process your request."
        }
    }
}
