//
//  StorytellingService.swift
//  storyteller
//
//  Created by Violette Lin on 2025/3/1.
//

import Foundation

struct StorytellingService {
    static let shared = StorytellingService()

    func fetchStory(prompt: String) async -> Result<StoryResponse, APIError> {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Config.openAIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "你是一位故事大師，擅長用不同風格講述故事。"],
                ["role": "user", "content": prompt]
            ],
            "temperature": 1,
            "top_p": 0.9,
            "max_tokens": 20
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                let response = StoryResponse(content: result.choices.first?.message.content ?? "", tokenUsage: result.usage.total_tokens)
                return .success(response)
            } else {
                return .failure(.decodedError(reason: "API response decoding failed"))
            }
        } catch {
            return .failure(.connectionError)
        }
    }
}

struct StoryResponse: Equatable {
    let content: String
    let tokenUsage: Int
}

struct OpenAIResponse: Codable {
    struct Usage: Codable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
    
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    
    let usage: Usage
    let choices: [Choice]
}

enum APIError: Error, Equatable {
    case statusError(statusCode: Int)
    case decodedError(reason: String)
    case connectionError
    case timeoutError
    case unexpectedError
    case dataCorruption(reason: String)
    case unauthorizedError
}
