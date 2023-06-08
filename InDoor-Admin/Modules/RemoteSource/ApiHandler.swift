//
//  ApiHandler.swift
//  InDoor-Admin
//
//  Created by Ahmed on 04/06/2023.
//

import Foundation
import Alamofire


protocol ApiService{
    func getAllBrands(completionHandler: @escaping(RootClass?) -> Void)
}
class ApiHandler:ApiService{
    func getAllBrands(completionHandler: @escaping(RootClass?) -> Void){
        let headers:HTTPHeaders = ["X-Shopify-Access-Token": "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"]
        let url = URL(string: "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/smart_collections.json")!
        AF.request(url,method: .get, headers: headers).response { response in
            switch response.result{
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(RootClass.self, from: data!)
                    completionHandler(result)
                }catch let error{
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
