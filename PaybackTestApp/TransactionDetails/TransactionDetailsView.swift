//
//  TransactionDetails.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import SwiftUI

struct TransactionDetailsView: View {
    let transaction: Transaction

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text(transaction.partnerDisplayName)
                .font(.title)
            if let details = transaction.transactionDetail.description {
                Text(details)
                    .font(.body)
            }
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(transaction: Mock.transactions[0])
    }
}
