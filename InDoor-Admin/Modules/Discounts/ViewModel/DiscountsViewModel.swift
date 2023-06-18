//
//  DiscountsViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import Foundation

class DiscountsViewModel{
    
    var network:ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    
    func getAllDiscountCoupons(priceRule:PriceRule, completionHandler: @escaping ([DiscountCodes]) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)/\(Constants.urlQueryDiscountCodes)\(Constants.urlExtension)"
        network.handleProduct(method: .get, parameters: [:], url: url) { (priceRulesContainer:RootClass?) in
            completionHandler(priceRulesContainer?.discountCodes ?? [])
        }
    }
    
    func addDiscountCode(discountCode:DiscountCodes ,priceRule:PriceRule, completionHandler: @escaping (DiscountCodes) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)/\(Constants.urlQueryDiscountCodes)\(Constants.urlExtension)"
        network.handleProduct(method: .post, parameters: Converter.encodeToJson(objectClass: RootClass(discountCode: discountCode))!, url: url) { (discountCodeContainer:RootClass?) in
            completionHandler(discountCodeContainer?.discountCode ?? DiscountCodes())
        }
    }
    
    func updateDiscountCode(discountCode:DiscountCodes ,priceRule:PriceRule, completionHandler: @escaping (DiscountCodes) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)/\(Constants.urlQueryDiscountCodes)/\(discountCode.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .put, parameters: Converter.encodeToJson(objectClass: RootClass(discountCode: discountCode))!, url: url) { (discountCodeContainer:RootClass?) in
            completionHandler(discountCodeContainer?.discountCode ?? DiscountCodes())
        }
    }
    
    func deleteDiscountCode(discountCode:DiscountCodes ,priceRule:PriceRule){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)/\(Constants.urlQueryDiscountCodes)/\(discountCode.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .delete, parameters: Converter.encodeToJson(objectClass: RootClass(discountCode: discountCode))!, url: url) { (_:RootClass?) in
        }
    }
}
