//
//  ApiHandler.swift
//  InDoor-Admin
//
//  Created by Ahmed on 04/06/2023.
//

import Foundation
import Alamofire


protocol ApiService{
    func handleProduct<T:Codable>(method: HTTPMethod, parameters:Parameters, url:String,completionHandler: @escaping(T?) -> Void)
}
class ApiHandler:ApiService{
    
    func handleProduct<T:Codable>(method: HTTPMethod, parameters:Parameters, url:String, completionHandler: @escaping(T?) -> Void){
        let headers:HTTPHeaders = [Constants.accessTokenHeader: Constants.accessKey]
        let url = URL(string: url)!
        AF.request(url,method: method, parameters: parameters, headers: headers).response { response in
            switch response.result{
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(T.self, from: data ?? Data())
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
