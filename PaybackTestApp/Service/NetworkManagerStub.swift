//
//  NetworkManagerStub.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

class NetworkManagerStub: NetworkManagerProtocol {
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func fetchTransactions() async throws -> [Transaction] {
        let (data, _) = try await URLSession.shared.data(from: Bundle.main.url(forResource: "PBTransactions", withExtension: "json")!)
        let response = try jsonDecoder.decode(Response.self, from: data)
        return response.items
    }
}
