//
//  CollectionProductsViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 09/06/2023.
//

import Foundation

class CollectionProductsViewModel{
    var network:ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    
    func getPrdouctsOfSpecificBrand(brandID:String, completionHandler: @escaping ([Product]) -> Void){
        let url =  "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/collections/\(brandID)/products.json"
        network.getData(url: url) { allProducts in
            completionHandler(allProducts?.products ?? [])
        }
    }
    
    func getSpecificProduct(productID:String, completionHandler: @escaping (Product) -> Void){
        let url =  "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/products/\(productID).json"
        network.getData(url: url) { response in
            completionHandler((response?.product)!)
        }
    }
}
