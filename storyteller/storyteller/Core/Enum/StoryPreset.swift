//
//  StoryPreset.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import Foundation

enum StoryPreset: String, CaseIterable {
    case creation = "創世神話（亞當與夏娃 / 盤古開天）"
    case journeyToTheWest = "西遊記 - 孫悟空大鬧天宮"
    case cinderella = "灰姑娘"
    case greekMythology = "宙斯與奧林匹斯眾神"
    case norseMythology = "雷神索爾的鎚子"
    case momotaro = "桃太郎"
    case harryPotter = "哈利波特 - 霍格華茲的第一天"
    case starWars = "星際大戰 - 路克對決達斯維達"
    case redCliff = "三國演義 - 赤壁之戰"
    
    var displayName: String { self.rawValue }
}
