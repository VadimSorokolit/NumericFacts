//
//  NumericFactInfo.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//
    
import Foundation
import SwiftData

@Model
final class NumericFact: Identifiable {
    
    // MARK: - Properties
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var index: Int
    var number:Int
    var factText: String
    
    
    // MARK: - Initializer
    
    init(
        index: Int = 1,
        number:Int = 0,
        factText: String = "",
    ) {
        self.index = index
        self.number = number
        self.factText = factText
    }
    
}
