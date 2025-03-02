//
//  HomeScreen.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import ComposableArchitecture
import SwiftUI

struct HomeScreen: View {
    
    @State private var selectedPreset: StoryPreset?
    @State private var selectedStyle: StoryStyle?
    @State private var generatedStory: String = "請選擇故事與風格後點擊「Submit」"
    @State private var tokenUsage: Int = 0
    
    let apiService = OpenAIService()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Story Presets")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(StoryPreset.allCases, id: \.self) { preset in
                            StoryPresetCell(preset: preset)
                                .padding()
                                .onTapGesture {
                                    selectedPreset = preset
                                }
                        }
                    }
                }
                HStack {
                    Text("Story Styles")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(StoryStyle.allCases, id: \.self) { style in
                            StoryStyleCell(style: style)
                                .padding()
                                .onTapGesture {
                                    selectedStyle = style
                                }
                        }
                    }
                }
                
                // Button to submit and trigger API
                Button {
                    if let preset = selectedPreset, let style = selectedStyle {
                        let prompt = "請幫我用\(style.displayName)風格講述\(preset.displayName)這個故事"
                        apiService.fetchStory(prompt: prompt) { response, tokens in
                            DispatchQueue.main.async {
                                self.generatedStory = response ?? "❌ 無法取得故事，請稍後再試"
                                self.tokenUsage = tokens ?? 0
                            }
                        }
                    }
                } label: {
                    Text("Submit")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Text("Token 使用量：\(tokenUsage)")
                    .font(.caption)
                    .padding()
                    .foregroundColor(.gray)
                
                Text(generatedStory)
                    .font(.title3)
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private func StoryPresetCell(preset: StoryPreset) -> some View {
        VStack {
            Text(preset.displayName)
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .background(Color.red.opacity(selectedPreset == preset ? 1 : 0.5))
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func StoryStyleCell(style: StoryStyle) -> some View {
        VStack {
            Text(style.displayName)
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .background(Color.blue.opacity(selectedStyle == style ? 1 : 0.5))
        .cornerRadius(10)
    }
}
    
#Preview {
    HomeScreen()
}
