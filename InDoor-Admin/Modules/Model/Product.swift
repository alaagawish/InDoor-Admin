//
//  Product.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import Foundation

struct Product: Codable {

    let id: Int
    let title: String?
    let bodyHtml: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt: String?
    let publishedAt: String?
    //let templateSuffix: Any
    let status: String?
    let publishedScope: String?
    let tags: String?
    let adminGraphqlApiId: String?
    let variants: [Variants]?
    let options: [Options]?
    let images: [Image]?
    let image: Image?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case bodyHtml = "body_html"
        case vendor = "vendor"
        case productType = "product_type"
        case createdAt = "created_at"
        case handle = "handle"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
    //    case templateSuffix = "template_suffix"
        case status = "status"
        case publishedScope = "published_scope"
        case tags = "tags"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case variants = "variants"
        case options = "options"
        case images = "images"
        case image = "image"
    }
}
