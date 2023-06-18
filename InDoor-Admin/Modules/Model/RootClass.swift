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
    var priceRules: [PriceRule]?
    var priceRule: PriceRule?
    var discountCodes: [DiscountCodes]?
    var discountCode: DiscountCodes?

	private enum CodingKeys: String, CodingKey {
        case discountCode = "discount_code"
        case discountCodes = "discount_codes"
        case priceRules = "price_rules"
		case smartCollections = "smart_collections"
        case products = "products"
        case product = "product"
        case priceRule = "price_rule"
	}

}
