//
//  Options.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import Foundation

struct Options: Codable {

    let id: Int?
    let productId: Int?
    let name: String?
    let position: Int?
    let values: [String]?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case name = "name"
        case position = "position"
        case values = "values"
    }
}
