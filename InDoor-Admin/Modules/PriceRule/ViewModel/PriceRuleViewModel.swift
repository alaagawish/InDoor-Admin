//
//  PriceRuleViewModel.swift
//  InDoor-Admin
//
//  Created by Ahmed on 17/06/2023.
//

import Foundation

class PriceRuleViewModel{
    
    var network:ApiService
    
    init(network: ApiService) {
        self.network = network
    }
    
    func getAllPriceRules(completionHandler: @escaping ([PriceRule]) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)\(Constants.urlExtension)"
        network.handleProduct(method: .get, parameters: [:], url: url) { (priceRulesContainer:RootClass?) in
            completionHandler(priceRulesContainer?.priceRules ?? [])
        }
    }
    
    func addPriceRule(priceRule: PriceRule,completionHandler: @escaping (PriceRule) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)\(Constants.urlExtension)"
        network.handleProduct(method: .post, parameters: Converter.encodeToJson(objectClass: RootClass(priceRule: priceRule))!, url: url) { (ruleContainer:RootClass?) in
            completionHandler((ruleContainer?.priceRule)!)
        }
    }
    
    func updatePriceRule(priceRule: PriceRule,completionHandler: @escaping (PriceRule) -> Void){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .put, parameters: Converter.encodeToJson(objectClass: RootClass(priceRule: priceRule))!, url: url) { (ruleContainer:RootClass?) in
            completionHandler((ruleContainer?.priceRule)!)
        }
    }
    
    func deletePriceRule(priceRule: PriceRule){
        let url = "\(Constants.rootUrl)/\(Constants.urlQueryPriceRules)/\(priceRule.id!)\(Constants.urlExtension)"
        network.handleProduct(method: .delete, parameters: Converter.encodeToJson(objectClass: RootClass(priceRule: priceRule))!, url: url) { (_:RootClass?) in}
    }
}
