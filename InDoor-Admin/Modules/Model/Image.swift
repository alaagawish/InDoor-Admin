//
//  Image.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct Image: Codable {
    
    let id: Int?
    let productId: Int?
    let position: Int?
    let createdAt: String?
    let updatedAt: String?
    let alt: String?
    let width: Int?
    let height: Int?
    let src: String?
    //let variantIds: [Any]
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case position = "position"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
        //    case variantIds = "variant_ids"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}
