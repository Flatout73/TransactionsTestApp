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
    func fetchTransactions() async throws -> [Transaction] {
        return []
    }
}
