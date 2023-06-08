//
//  Rules.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct Rules: Codable {

	let column: String
	let relation: String
	let condition: String

	private enum CodingKeys: String, CodingKey {
		case column = "column"
		case relation = "relation"
		case condition = "condition"
	}

}