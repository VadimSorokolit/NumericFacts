//
//  Item.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
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
