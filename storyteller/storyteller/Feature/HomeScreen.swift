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
    
    var body: some View {
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
                    // Trigger API
                    print("Preset: \(preset.displayName), Style: \(style.displayName)")
                }
            } label: {
                Text("Submit")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
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
