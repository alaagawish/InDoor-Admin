//
//  Image.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct Image: Codable {

	let createdAt: String
	let alt: String?
	let width: Int
	let height: Int
	let src: String

	private enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case alt = "alt"
		case width = "width"
		case height = "height"
		case src = "src"
	}

}
