//
//  PaybackTestAppApp.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import SwiftUI

@main
struct PaybackTestApp: App {
    let networkManager: NetworkManagerProtocol = NetworkManagerStub()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TransactionsView(viewModel: TransactionsViewModel(networkManager: networkManager,
                                                                  networkStatusManager: NetworkStatusManager()))
            }
        }
    }
}
