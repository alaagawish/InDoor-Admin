//
//  Options.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import Foundation

struct Options: Codable {

    var id: Int?
    var productId: Int?
    var name: String?
    var position: Int?
    var values: [String]?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case name = "name"
        case position = "position"
        case values = "values"
    }
}
