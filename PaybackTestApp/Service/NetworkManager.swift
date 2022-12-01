//
//  NetworkManager.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

final class NetworkManager: NetworkManagerProtocol {
    #if DEBUG
    let baseURL = "https://api-test.payback.com/transactions"
    #else
    let baseURL = "https://api.payback.com/transactions"
    #endif

    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func fetchTransactions() async throws -> [Transaction] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: baseURL)!)
        let response = try jsonDecoder.decode(Response.self, from: data)
        return response.items
    }
}
