//
//  NumberFactResponse.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//
    
struct NumberFactResponse: Decodable {
    let text: String
    let number: Int
    let found: Bool
    let type: String
}
