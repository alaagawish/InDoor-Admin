//
//  SmartCollections.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct SmartCollections: Codable {

    var id: Int
    var handle: String
    var title: String
    var updatedAt: String
    var bodyHtml: String
    var publishedAt: String
    var sortOrder: String
    var templateSuffix: String?
    var disjunctive: Bool
    var rules: [Rules]
    var publishedScope: String
    var adminGraphqlApiId: String
    var image: Image

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case handle = "handle"
		case title = "title"
		case updatedAt = "updated_at"
		case bodyHtml = "body_html"
		case publishedAt = "published_at"
		case sortOrder = "sort_order"
		case templateSuffix = "template_suffix"
		case disjunctive = "disjunctive"
		case rules = "rules"
		case publishedScope = "published_scope"
		case adminGraphqlApiId = "admin_graphql_api_id"
		case image = "image"
	}

}
