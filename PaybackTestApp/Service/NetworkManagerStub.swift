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
        switch Int.random(in: 0...3) {
        case 0:
            throw ServiceError.randomError
        case 1:
            throw ServiceError.offline
        default:
            let (data, _) = try await URLSession.shared.data(from: Bundle.main.url(forResource: "PBTransactions", withExtension: "json")!)
            try await Task.sleep(nanoseconds: 150_000_000)
            let response = try jsonDecoder.decode(Response.self, from: data)
            return response.items
        }
    }
}
