//
//  Item.swift
//  storyteller
//
//  Created by Violette Lin on 2025/2/28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
