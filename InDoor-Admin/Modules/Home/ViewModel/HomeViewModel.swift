//
//  HomeViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 04/06/2023.
//

import Foundation

class HomeViewModel{
    
    var network:ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    func getAvailableBrands(completionHandler: @escaping ([SmartCollections]) -> Void){
        let url = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/smart_collections.json"
        network.getData(url: url) { allBrands in
            completionHandler(allBrands?.smartCollections ?? [])
        }
    }
}
