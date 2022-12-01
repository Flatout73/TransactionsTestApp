//
//  Transaction.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

struct Transaction: Decodable, Hashable {
    struct Alias: Decodable, Hashable {
        let reference: String
    }
    let partnerDisplayName: String
    let category: Category
    let transactionDetail: TransactionDetails
}
