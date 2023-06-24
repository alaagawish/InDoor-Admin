//
//  addVariant.swift
//  InDoor-Admin
//
//  Created by Ahmed on 15/06/2023.
//

import UIKit

//=================================================================================
extension AddProductViewController {
    
    // third page logic
    
    func setThirdPageUI(){
        sizeTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        sizeTextField.setRightPaddingPoints(8)
        sizeTextField.setLeftPaddingPoints(8)
        colorTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        colorTextField.setRightPaddingPoints(8)
        colorTextField.setLeftPaddingPoints(8)
        priceTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        priceTextField.setRightPaddingPoints(8)
        priceTextField.setLeftPaddingPoints(8)
        quantityTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        quantityTextField.setRightPaddingPoints(8)
        quantityTextField.setLeftPaddingPoints(8)
    }
    
    @IBAction func saveVariant(_ sender: Any) {
        if saveVariantData(){
            priceTextField.text = ""
            quantityTextField.text = ""
            sizeTextField.text = ""
            colorTextField.text = ""
        }
    }
    
    func checkAndNavigateToDetails(){
        if checkVariantFieldsAreFilled() {
            showVariantHandlingAlert()
        }else{
            if product.variants!.isEmpty {
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.atLeastOneVariant)
            }else{
                navigateToDetails()
            }
        }
    }
    
    func saveVariantData() -> Bool{
        if checkVariantFieldsAreFilled() {
            if checkPriceValidity(){
                if checkQuantityValidity(){
                    if checkVariantIsGenuine(){
                        let variant = Variants(title: "\(sizeTextField.text!) / \(colorTextField.text!)",price:priceTextField.text!,inventoryManagement: "shopify", option1: sizeTextField.text!, option2: colorTextField.text!, inventoryQuantity: Int(quantityTextField.text!), oldInventoryQuantity: Int(quantityTextField.text!))
                        product.variants?.append(variant)
                        checkAndAddOptions()
                        return true
                    }else{
                        InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.duplicatedVariant)
                        return false
                    }
                }else{
                    InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterValidQuantity)
                    return false
                }
            }else{
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.validPrice)
                return false
            }
        }else{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.emptyFields)
            return false
        }
    }
    
    func checkVariantFieldsAreFilled() -> Bool{
        if priceTextField.text == "" || quantityTextField.text == "" || sizeTextField.text == "" || colorTextField.text == "" {
            return false
        }
        return true
    }
    
    func checkPriceValidity() -> Bool {
        if Double(priceTextField.text!) != nil {
            return true
        }else{
            return false
        }
    }
    
    func checkQuantityValidity() -> Bool {
        if Int(quantityTextField.text!) != nil {
            return true
        }else{
            return false
        }
    }
    
    func checkVariantIsGenuine() -> Bool {
        for variant in product.variants! {
            if variant.title?.lowercased() == "\(sizeTextField.text!) / \(colorTextField.text!.lowercased())" {
                return false
            }
        }
        return true
    }
    
    func showVariantHandlingAlert(){
        let alert = UIAlertController(title: Constants.warning, message: Constants.variantHandlingQuery, preferredStyle: .alert)
        let actionSaveAndContinue = UIAlertAction(title: Constants.save, style: .default) { _ in
            if self.saveVariantData(){
                self.navigateToDetails()
            }
        }
        let actionDiscardAndContinue = UIAlertAction(title: Constants.discard, style: .destructive) { _ in
            if self.product.variants!.isEmpty{
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.atLeastOneVariant)
            }else{
                self.navigateToDetails()
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(actionSaveAndContinue)
        alert.addAction(actionDiscardAndContinue)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func checkAndAddOptions(){
        if !(product.options![0].values!.contains(sizeTextField.text!)) {
            product.options![0].values?.append(sizeTextField.text!)
        }
        if !(product.options![1].values!.contains(colorTextField.text!)) {
            product.options![1].values?.append(colorTextField.text!)
        }
    }
}
