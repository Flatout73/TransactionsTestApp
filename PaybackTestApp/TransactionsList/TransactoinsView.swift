//
//  ContentView.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import SwiftUI

struct TransactionsView: View {
    @StateObject
    var viewModel: TransactionsViewModel

    var body: some View {
        List {
            ForEach(viewModel.transactions, id: \.self, content: { transaction in
                NavigationLink(destination: {
                    TransactionDetailsView(transaction: transaction)
                }) {
                    TransactionView(transaction: transaction)
                }
            })
        }
        .task {
            try! await viewModel.fetch()
        }
        .navigationTitle("transactions")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Menu(content: {
                    ForEach(TransactionsViewModel.Sorts.allCases) { sort in
                        Button(action: {
                            viewModel.sortedBy = sort
                        }, label: {
                            Text(sort.localizedTitle)
                        })
                    }
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                })
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: TransactionsViewModel(networkManager: NetworkManagerStub()))
    }
}
