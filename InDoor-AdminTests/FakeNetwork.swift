//
//  FakeNetwork.swift
//  InDoor-AdminTests
//
//  Created by Ahmed on 23/06/2023.
//

import Foundation
import Alamofire
@testable import InDoor_Admin

class FakeNetwork: ApiService {
    func handleProduct<T:Codable>(method: Alamofire.HTTPMethod, parameters: Alamofire.Parameters, url: String, completionHandler: @escaping (T?) -> Void) {
        let brandsContainer = RootClass(smartCollections: [SmartCollections(id: 1), SmartCollections(id: 2)])
        let brandProductsContainer = RootClass(products: [Product(id: 1, vendor: "ADIDAS"),Product( id: 2, vendor: "ADIDAS"), Product(id: 3, vendor: "ADIDAS")])
        let specificProductContainer = RootClass(product: Product(id: 1, title: "Specific Product"))
        if url.contains("smart_collections"){
            completionHandler(brandsContainer as? T)
        }
        else if url.contains("smart_collections") && url.contains("products"){
            completionHandler(brandProductsContainer as? T)
        }else if url.contains("products/"){
            completionHandler(specificProductContainer as? T)
        }
    }
}
