//
//  Rules.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct Rules: Codable {

    var column: String
    var relation: String
    var condition: String

	private enum CodingKeys: String, CodingKey {
		case column = "column"
		case relation = "relation"
		case condition = "condition"
	}

}
