//
//  OpenAIService.swift
//  storyteller
//
//  Created by Violette Lin on 2025/3/1.
//

import Foundation

struct OpenAIService {
    
    func fetchStory(prompt: String, completion: @escaping (String?) -> Void) {
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
            "temperature": 0.7,
            "max_tokens": 30
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("❌ API 請求失敗：\(error?.localizedDescription ?? "未知錯誤")")
                completion(nil)
                return
            }
            
            if let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = result["choices"] as? [[String: Any]],
               let text = choices.first?["message"] as? [String: Any],
               let content = text["content"] as? String {
                completion(content)
            } else {
                print("❌ API 回應解析失敗")
                completion(nil)
            }
        }.resume()
    }
}
