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
        let url =  "\(Constants.rootUrl)/\(Constants.urlQueryCollections)/\(brandID)/\(Constants.urlQueryProducts)\(Constants.urlExtension)"
        network.handleProduct(method: .get, parameters: [:], url: url) { (allProducts:RootClass?) in
            completionHandler(allProducts?.products ?? [])
        }
    }
    
    func getSpecificProduct(productID:String, completionHandler: @escaping (Product) -> Void){
        let url =  "\(Constants.rootUrl)/\(Constants.urlQueryProducts)/\(productID)\(Constants.urlExtension)"
        network.handleProduct(method: .get, parameters: [:], url: url) { (response:RootClass?) in
            completionHandler((response?.product)!)
        }
    }
    
    func deleteProduct(product: Product) {
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryProducts)/\(product.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .delete, parameters: Converter.encodeToJson(objectClass: product)!, url: url) { (_:RootClass?) in}
    }
}
