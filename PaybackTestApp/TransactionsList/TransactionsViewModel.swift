//
//  ContentViewModel.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation
import SwiftUI

class TransactionsViewModel: ObservableObject {
    enum Sorts: String, CaseIterable, Identifiable {
        case date
        case category

        var localizedTitle: LocalizedStringKey {
            return LocalizedStringKey(self.rawValue)
        }

        var id: String { self.rawValue }
    }
    @Published
    var transactions: [Transaction] = []

    var sortedBy: Sorts = .date {
        didSet {
            sort()
        }
    }

    let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    @MainActor
    func fetch() async throws {
        self.transactions = try await networkManager.fetchTransactions()
        sort()
    }

    func sort() {
        transactions.sort(by: {
            if sortedBy == .date {
                return $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
            } else {
                return $0.category.rawValue > $1.category.rawValue
            }
        })
    }
}
