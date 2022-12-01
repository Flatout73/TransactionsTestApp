//
//  ServiceError.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

enum ServiceError: LocalizedError {
    case offline
    case randomError

    var errorDescription: String? {
        switch self {
        case .offline:
            return NSLocalizedString("offline_error", comment: "error")
        case .randomError:
            return NSLocalizedString("Random error", comment: "error")
        }
    }
}
