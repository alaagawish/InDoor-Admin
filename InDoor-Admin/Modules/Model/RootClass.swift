//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct RootClass: Codable {

    var smartCollections: [SmartCollections]?
    var products: [Product]?
    var product: Product?

	private enum CodingKeys: String, CodingKey {
		case smartCollections = "smart_collections"
        case products = "products"
        case product = "product"
	}

}
