//
//  HomeScreen.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import ComposableArchitecture
import SwiftUI

struct HomeScreen: View {
    
    let store: Store<StorytellerReducer.State, StorytellerReducer.Action> = Store(
        initialState: StorytellerReducer.State(),
        reducer: {
            StorytellerReducer()
        }
    )
    
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
                                    store.send(.selectPreset(preset))
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
                                    store.send(.selectStyle(style))
                                }
                        }
                    }
                }
                
                // Button to submit and trigger API
                Button {
                    store.send(.generateStory)
                } label: {
                    Text("Submit")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Text("Token 使用量：\(store.tokenUsage)")
                    .font(.caption)
                    .padding()
                    .foregroundColor(.gray)
                
                Text(store.generatedStory)
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
        .background(Color.red.opacity(store.selectedPreset == preset ? 1 : 0.5))
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
        .background(Color.blue.opacity(store.selectedStyle == style ? 1 : 0.5))
        .cornerRadius(10)
    }
}
    
#Preview {
    HomeScreen()
}
