//
//  StoryStyle.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import Foundation

enum StoryStyle: String, CaseIterable {
    case poetry = "唐詩"
    case bible = "聖經"
    case medievalKnight = "中古騎士"
    case shakespeare = "莎士比亞"
    case advertisement = "洗腦廣告"
    case projectReport = "專案報告"
    case pilotBroadcast = "機長廣播"
    case childrenBook = "兒童繪本"
    case sciFi = "科幻技術"
    
    var displayName: String { self.rawValue }
}
