//
//  NetworkStatus.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation
import Network

final class NetworkStatusManager: ObservableObject {
    private let monitor = NWPathMonitor()

    @Published
    var isOn = false

    init() {
        start()
    }

    private func start() {
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler in
            DispatchQueue.main.async {
                if pathUpdateHandler.status == .satisfied {
                    self?.isOn = true
                } else {
                    self?.isOn = false
                }
            }
        }
    }
}
