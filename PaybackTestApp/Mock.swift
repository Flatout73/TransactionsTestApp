//
//  Mock.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation


enum Mock {
    static let transactions: [Transaction] = [
        Transaction(partnerDisplayName: "REWE Group", category: .one,
                    transactionDetail: TransactionDetails(description: "Punkte sammeln",
                                                          bookingDate: Date(),
                                                          value: TransactionDetails.Value(amount: 124, currency: "PBP")))
    ]
}
