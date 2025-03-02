//
//  StoryStyle.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import Foundation

enum StoryStyle: String, CaseIterable {
    case poetry = "李白"
    case magical = "哈利波特"
    case advertisement = "賣場廣告"
    case projectReport = "專案報告"
    case pilotBroadcast = "機長廣播"
    case childrenBook = "兒童繪本"
    
    var displayName: String { self.rawValue }
}
