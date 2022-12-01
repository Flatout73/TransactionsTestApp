//
//  Response.swift
//  PaybackTestApp
//
//  Created by Leonid Lyadveykin on 01.12.2022.
//

import Foundation

struct Response: Decodable {
    let items: [Transaction]
}
