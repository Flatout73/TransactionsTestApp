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

    @ViewBuilder
    var main: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .error(let error):
            Text(error.localizedDescription)
        case .done:
            List {
                ForEach(viewModel.filteredTransactions, id: \.self, content: { transaction in
                    NavigationLink(destination: {
                        TransactionDetailsView(transaction: transaction)
                    }) {
                        TransactionView(transaction: transaction)
                    }
                })

                HStack {
                    Text("total")
                    Spacer()
                    Text(viewModel.sum, format: .currency(code: viewModel.currency))
                }
            }
        }
    }

    var body: some View {
        main
        .task {
            await viewModel.fetch()
        }
        .navigationTitle("transactions")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Menu(content: {
                    ForEach(Category.allCases) { filter in
                        Button(action: {
                            if viewModel.filteredBy == filter {
                                viewModel.filteredBy = nil
                            } else {
                                viewModel.filteredBy = filter
                            }
                        }, label: {
                            HStack {
                                Text(filter.localizedTitle)
                                if filter == viewModel.filteredBy {
                                    Image(systemName: "checkmark")
                                }
                            }
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
        TransactionsView(viewModel: TransactionsViewModel(networkManager: NetworkManagerStub(), networkStatusManager: NetworkStatusManager()))
    }
}
