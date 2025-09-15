//
//  FactDetailsView.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//

import SwiftUI

struct FactDetailsView: View {
    let numberFact: NumericFact
    
    var body: some View {
        ScrollView {
            DetailsCell(
                number: numberFact.number,
                numberFact: numberFact.factText,
                isPreview: false
            )
            .padding(.horizontal, 20.0)
            .padding(.vertical, 8.0)
        }
        .navigationTitle("Number fact")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
