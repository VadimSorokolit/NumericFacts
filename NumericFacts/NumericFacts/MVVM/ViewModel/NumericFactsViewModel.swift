//
//  NumericFactsViewModel.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//

import Foundation
import Observation

@Observable
class NumericFactsViewModel {
    
    // MARK: - Properties. Public
    
    var inputText: String = ""
    var inputNumber: Int? {
        Int(self.inputText)
    }
    var randomNumber: Int?
    var currentNumber: Int? {
        inputNumber ?? randomNumber
    }
    var factText: String = ""
    var isLoading: Bool = false
    var errorMessage: AppError?
    
    // MARK: - Properties. Private
    
    private let service: NetworkServiceProtocol
    
    // MARK: - Initializer
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Methods. Public
    
    func fetchFactFor(number: Int) async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            let fact = try await self.service.fact(for: number)
            self.factText = fact
        } catch {
            self.errorMessage = AppError(message: error.localizedDescription)
        }
    }
    
    func fetchRandomFact() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            let fact = try await self.service.fetchRandomNumberFact()
            self.factText = fact.text
            self.randomNumber = fact.number
        } catch {
            self.errorMessage = AppError(message: error.localizedDescription)
        }
    }
}
