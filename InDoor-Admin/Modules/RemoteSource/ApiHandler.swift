//
//  ApiHandler.swift
//  InDoor-Admin
//
//  Created by Ahmed on 04/06/2023.
//

import Foundation
import Alamofire


protocol ApiService{
    func getData(url:String,completionHandler: @escaping(RootClass?) -> Void)
    func updateProduct(method:HTTPMethod, url:String, parameters: Parameters)
}
class ApiHandler:ApiService{
    
    func getData(url:String, completionHandler: @escaping(RootClass?) -> Void){
        let headers:HTTPHeaders = ["X-Shopify-Access-Token": "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"]
        let url = URL(string: url)!
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
    
    func updateProduct(method:HTTPMethod, url:String, parameters: Parameters){
        let headers:HTTPHeaders = ["X-Shopify-Access-Token": "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"
        ]
        let url = URL(string: url)!
        AF.request(url,method: method,parameters: parameters, encoding:URLEncoding.httpBody , headers: headers).response{ response in
            switch response.result {
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(RootClass.self, from: data!)
                    print("updated")
                }catch let error{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
