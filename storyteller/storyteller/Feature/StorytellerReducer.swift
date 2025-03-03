//
//  StorytellerReducer.swift
//  storyteller
//
//  Created by Violette Lin on 2025/3/2.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct StorytellerReducer {
    let service: StorytellingService = .shared

    @ObservableState
    struct State: Equatable {
        var loadingPhase: LoadingPhase = .initial
        var generatedStory: String = ""
        var selectedPreset: StoryPreset?
        var selectedStyle: StoryStyle?
        var tokenUsage: Int = 0
    }

    enum Action: Equatable {
        case generateStory
        case handleStoryResponse(Result<StoryResponse, APIError>)
        case selectPreset(StoryPreset)
        case selectStyle(StoryStyle)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            print("[Storytelling] A \(action) ")

            switch action {
            case .generateStory:
                guard let preset = state.selectedPreset, let style = state.selectedStyle else {
                    return .none
                }
                let prompt = "請用\(style.displayName)風格來說\(preset.displayName)這個故事"
                return .run { send in
                    await send(.handleStoryResponse(await service.fetchStory(prompt: prompt)))
                }

            case let .handleStoryResponse(.success(response)):
                state.generatedStory = response.content
                state.tokenUsage = response.tokenUsage
                state.loadingPhase = .loaded
                return .none

            case .handleStoryResponse(.failure):
                state.loadingPhase = .loaded
                return .none

            case let .selectPreset(preset):
                state.selectedPreset = preset
                return .none

            case let .selectStyle(style):
                state.selectedStyle = style
                return .none
            }
        }
    }
}
