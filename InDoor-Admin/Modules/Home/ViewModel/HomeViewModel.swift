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
        network.getAllBrands { allBrands in
            completionHandler(allBrands?.smartCollections ?? [])
        }
    }
}
