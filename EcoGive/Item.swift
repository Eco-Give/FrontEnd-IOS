//
//  Item.swift
//  EcoGive
//
//  Created by oumayma cherif on 29/11/2023.
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
