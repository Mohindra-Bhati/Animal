//
//  Item.swift
//  Animals
//
//  Created by Mohindra Bhati on 08/07/24.
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
