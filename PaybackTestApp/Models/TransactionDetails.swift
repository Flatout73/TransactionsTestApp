//
//  TransactionDetails.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

struct TransactionDetails: Decodable, Hashable {
    struct Value: Decodable, Hashable {
        let amount: Double
        let currency: String
    }
    let description: String?
    let bookingDate: Date
    let value: Value
}
