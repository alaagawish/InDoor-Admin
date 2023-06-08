//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 04, 2023
//
import Foundation

struct RootClass: Codable {

	let smartCollections: [SmartCollections]

	private enum CodingKeys: String, CodingKey {
		case smartCollections = "smart_collections"
	}

}