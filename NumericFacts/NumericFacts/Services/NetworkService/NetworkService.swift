//
//  NetworkService.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fact(for number: Int) async throws -> String
    func fetchRandomNumberFact() async throws -> NumberFactResponse
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Objects
    
    private struct Constants {
        static let baseURL: String = "http://numbersapi.com/"
        static let randomMathPath: String = "random/math?json"
    }
    
    // MARK: - Properties. Private
    
    private let session: URLSession
    
    // MARK: - Initializer
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Methods. Public
    
    func fact(for number: Int) async throws -> String {
        guard let url = URL(string: Constants.baseURL + "\(number)") else {
            throw URLError(.badURL)
        }
        let fact = try await fetchText(from: url)
        
        return fact
    }
    
    func fetchRandomNumberFact() async throws -> NumberFactResponse {
        guard let url = URL(string: Constants.baseURL + Constants.randomMathPath) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let factResponse = try JSONDecoder().decode(NumberFactResponse.self, from: data)
        return factResponse
    }
    
    // MARK: - Methods. Private
    
    private func fetchText(from url: URL) async throws -> String {
        let (data, response) = try await self.session.data(from: url)
        guard let http = response as? HTTPURLResponse, (200 ..< 300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    
}
