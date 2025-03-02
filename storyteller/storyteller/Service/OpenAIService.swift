//
//  OpenAIService.swift
//  storyteller
//
//  Created by Violette Lin on 2025/3/1.
//

import Foundation

struct OpenAIService {
    
    func fetchStory(prompt: String, completion: @escaping (String?, Int?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Config.openAIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "你是一位故事大師，擅長用不同風格講述故事。故事盡可能簡短但完整。"],
                ["role": "user", "content": prompt]
            ],
            "temperature": 1,
            "max_tokens": 200
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("❌ API 請求失敗：\(error?.localizedDescription ?? "未知錯誤")")
                completion(nil, 0)
                return
            }
            
            if let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                let content = result.choices.first?.message.content ?? "❌ 無回應"
                let totalTokens = result.usage.total_tokens
                completion(content, totalTokens)
            } else {
                print("❌ API 回應解析失敗")
                completion(nil, nil)
            }
        }.resume()
    }
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
