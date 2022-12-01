//
//  TransactionView.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(transaction.partnerDisplayName)
                Text(transaction.transactionDetail.value.amount,
                     format: .currency(code: transaction.transactionDetail.value.currency))
                .font(.title2)
            }
            Spacer()
            Text(transaction.transactionDetail.bookingDate, style: .date)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: Mock.transactions[0])
    }
}
