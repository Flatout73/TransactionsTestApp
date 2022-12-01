//
//  Category.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation
import SwiftUI

enum Category: Int, Decodable, Hashable, CaseIterable, Identifiable {
    case grocery = 1
    case sport
    case other

    var localizedTitle: LocalizedStringKey {
        switch self {
        case .grocery:
            return LocalizedStringKey("grocery")
        case .sport:
            return LocalizedStringKey("sport")
        case .other:
            return LocalizedStringKey("other")
        }
    }

    var id: String { String(self.rawValue) }
}
