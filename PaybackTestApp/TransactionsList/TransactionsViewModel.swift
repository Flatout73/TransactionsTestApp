//
//  ContentViewModel.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation
import SwiftUI
import Combine

class TransactionsViewModel: ObservableObject {
    enum Sorts: String {
        case date
        case category
    }
    enum State {
        case loading
        case error(Error)
        case done
    }
    @Published
    private var transactions: [Transaction] = []

    @Published
    var state = State.loading

    var filteredTransactions: [Transaction] {
        if let filter = filteredBy {
            return transactions.filter({ $0.category == filter  })
        } else {
            return transactions
        }
    }

    var sum: Double {
        return transactions.reduce(0, { $0 + $1.transactionDetail.value.amount })
    }

    var currency: String {
        return transactions.first?.transactionDetail.value.currency ?? "-"
    }

    @Published
    var filteredBy: Category?

    let networkManager: NetworkManagerProtocol
    let networkStatusManager: NetworkStatusManager

    var cancellable = Set<AnyCancellable>()

    init(networkManager: NetworkManagerProtocol, networkStatusManager: NetworkStatusManager) {
        self.networkManager = networkManager
        self.networkStatusManager = networkStatusManager

        networkStatusManager.$isOn
            .sink(receiveValue: { [weak self] in
                guard let self else { return }
                if !$0 {
                    self.state = .error(ServiceError.offline)
                } else {
                    Task {
                        await self.fetch()
                    }
                }
            })
            .store(in: &cancellable)
    }

    @MainActor
    func fetch() async {
        state = .loading
        do {
            self.transactions = try await networkManager
                .fetchTransactions()
                .sorted(by: {
                    return $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
                })
            state = .done
        } catch {
            state = .error(error)
        }

    }
}
