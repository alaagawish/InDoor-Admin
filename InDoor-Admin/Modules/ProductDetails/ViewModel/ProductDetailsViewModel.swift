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
    
    func updateProduct(product:Product, imagesToDelete:[Image]) {
        let url = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/products/\(product.id).json"
        network.updateProduct(method: .put, url: url, parameters: Converter.encodeToJson(objectClass: RootClass(product:product))!)
        updateImages(product: product,imagesToDelete: imagesToDelete)
    }
    
    func updateImages(product:Product, imagesToDelete:[Image]){
        for image in imagesToDelete {
            if(image.id != nil){
                let url = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/products/\(product.id)/images/\(image.id!).json"
                network.updateProduct(method: .delete, url: url, parameters: Converter.encodeToJson(objectClass: image)!)
            }
        }
        for image in product.images!{
            if(image.id != nil){
                let url = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/products/\(product.id)/images/\(image.id!).json"
                network.updateProduct(method: .put, url: url, parameters: Converter.encodeToJson(objectClass: image)!)
            }
        }
    }
}
