//
//  Item.swift
//  LibraryManagement
//
//  Created by Nuzulul Salsabila on 23/11/24.
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
