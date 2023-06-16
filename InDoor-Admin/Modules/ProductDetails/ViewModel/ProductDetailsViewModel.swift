//
//  ProductDetailsViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 13/06/2023.
//

import Foundation

class ProductDetailsViewModel{
    var network: ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    
    func addProduct(product: Product){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryProducts)\(Constants.urlExtension)"
        network.handleProduct(method: .post, parameters: Converter.encodeToJson(objectClass:RootClass(product: product))!, url: url) { (_:RootClass?) in
        }
    }
    
    func updateProduct(product:Product, imagesToDelete:[Image]) {
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryProducts)/\(product.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .put, parameters: Converter.encodeToJson(objectClass: RootClass(product:product))!, url: url) { (_:RootClass?) in}
        updateImages(product: product,imagesToDelete: imagesToDelete)
    }
    
    func updateImages(product:Product, imagesToDelete:[Image]){
        for image in imagesToDelete {
            if(image.id != nil){
                let url = "\(Constants.rootUrl)/\(Constants.urlQueryProducts)/\(product.id!)/\(Constants.urlQueryImages)/\(image.id!)\(Constants.urlExtension)"
                network.handleProduct(method: .delete, parameters: Converter.encodeToJson(objectClass: image)!, url: url) { (_:RootClass?) in}
            }
        }
    }
}
