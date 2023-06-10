//
//  AllProductsViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 09/06/2023.
//

import Foundation

class AllProductsViewModel{
    var network:ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    
    func getAllProducts(completionHandler: @escaping ([Product]) -> Void){
        let url =  "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/products.json"
        network.getData(url: url) { allProducts in
            completionHandler(allProducts?.products ?? [])
        }
    }
}
