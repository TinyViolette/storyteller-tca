//
//  StoryPreset.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import Foundation

enum StoryPreset: String, CaseIterable {
    
    case bullet = "讓子彈飛"
    case godfather = "教父"
    case inception = "全面啟動"
    case starWars = "星際大戰"
    case titanic = "鐵達尼號"
    case matrix = "駭客任務"
    case harryPotter = "哈利波特"
    case lordOfTheRings = "魔戒"
    case avatar = "阿凡達"
    case jurassicPark = "侏羅紀公園"
    case theLionKing = "獅子王"
    case theAvengers = "復仇者聯盟"
    
    var displayName: String { self.rawValue }
}
