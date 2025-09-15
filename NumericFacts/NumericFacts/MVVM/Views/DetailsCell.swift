//
//  DetailsCell.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//

import SwiftUI

struct DetailsCell: View {
    @Environment(NumericFactsViewModel.self) private var viewModel
    let number: Int
    let numberFact: String
    var isPreview: Bool
    
    var body: some View {
        HStack(spacing: 10.0) {
            Text("\(number)")
                .font(.headline)
                .foregroundStyle(.purple)
            
            Spacer()
            
            Text(numberFact)
                .font(.subheadline)
                .italic()
            
            Spacer()
        }
        .lineLimit(isPreview ? 1 : nil)
        .padding(.horizontal, 20.0)
        .padding(.vertical, 8.0)
    }
    
}
