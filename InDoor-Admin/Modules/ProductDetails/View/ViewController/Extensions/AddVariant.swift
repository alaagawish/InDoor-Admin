//
//  AddVariant.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController {
    //add variant
    
    @IBAction func addVariant(_ sender: Any) {
        curtainView.isHidden = false
        addVariantOverlayView.isHidden = false
        addVariantOverlayView.giveShadowAndRadius(shadowRadius: 5, cornerRadius: 20)
        addVariantSizeTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        addVariantSizeTextField.setRightPaddingPoints(8)
        addVariantSizeTextField.setLeftPaddingPoints(8)
        addVariantColorTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        addVariantColorTextField.setRightPaddingPoints(8)
        addVariantColorTextField.setLeftPaddingPoints(8)
        addVariantPriceTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        addVariantPriceTextField.setRightPaddingPoints(8)
        addVariantPriceTextField.setLeftPaddingPoints(8)
        addVariantQuantityTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        addVariantQuantityTextField.setRightPaddingPoints(8)
        addVariantQuantityTextField.setLeftPaddingPoints(8)
    }
    
    @IBAction func exitAddingVariantView(_ sender: Any) {
        curtainView.isHidden = true
        addVariantOverlayView.isHidden = true
        addVariantSizeTextField.text = ""
        addVariantColorTextField.text = ""
        addVariantPriceTextField.text = ""
        addVariantQuantityTextField.text = ""
    }
    
    @IBAction func doneAddingVariant(_ sender: Any) {
        let variantName = "\(addVariantSizeTextField.text!) / \(addVariantColorTextField.text!)"
        if checkForEmptyFields() {
            presentAlert(title: "Error", message: "Please Fill All Fields")
        }else if checkFieldsValidity(){
            presentAlert(title: "Error", message: "Wrong input for price or quantity")
        }else if checkDuplicatedVariant(variantName: variantName) {
            presentAlert(title: "Error", message: "Variant Already Exists")
        }else{
            addVariantToProduct(variantName:variantName)
            checkAndAddOptions()
            price.text = "Select Size"
            stockCount.text = "Select Size"
            initializeUI()
            selectedSize = nil
            selectedColor = nil
            sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
            colorCollectionHandler.colorArr = product.options?[1].values ?? []
            curtainView.isHidden = true
            addVariantOverlayView.isHidden = true
            addVariantSizeTextField.text = ""
            addVariantColorTextField.text = ""
            addVariantPriceTextField.text = ""
            addVariantQuantityTextField.text = ""
            
        }
    }
    
    func checkForEmptyFields() -> Bool {
        if addVariantSizeTextField.text!.isEmpty || addVariantColorTextField.text!.isEmpty || addVariantPriceTextField.text!.isEmpty || addVariantQuantityTextField.text!.isEmpty {
            return true
        }else{
            return false
        }
    }
    
    func checkFieldsValidity() -> Bool {
        if Double(addVariantPriceTextField.text ?? "") == nil || Int(addVariantQuantityTextField.text ?? "") == nil {
            return true
        }else{
            return false
        }
    }
    
    func checkDuplicatedVariant(variantName: String) -> Bool {
        for variant in product.variants! {
            if variant.title == variantName {
                return true
            }
        }
        return false
    }
    
    func addVariantToProduct(variantName: String){
        let variantPrice = addVariantPriceTextField.text
        let variantQuantity = addVariantQuantityTextField.text
        let variantSize = addVariantSizeTextField.text!
        let variantColor = addVariantColorTextField.text!
        let variant = Variants(id: nil, productId: product.id, title: variantName, price:variantPrice , sku: nil, position: nil, inventoryPolicy: nil, compareAtPrice: nil, fulfillmentService: nil, inventoryManagement: nil, option1: variantSize, option2: variantColor, option3: nil, createdAt: nil, updatedAt: nil, taxable: nil, barcode: nil, grams: nil, imageId: nil, weight: nil, weightUnit: nil, inventoryItemId: nil, inventoryQuantity: Int(variantQuantity ?? "0"), oldInventoryQuantity: Int(variantQuantity ?? "0"), requiresShipping: nil, adminGraphqlApiId: nil)
        product.variants?.append(variant)
    }
    
    func checkAndAddOptions(){
        if !(product.options![0].values!.contains(addVariantSizeTextField.text!)) {
            product.options![0].values?.append(addVariantSizeTextField.text!)
        }
        if !(product.options![1].values!.contains(addVariantColorTextField.text!)) {
            product.options![1].values?.append(addVariantColorTextField.text!)
        }
    }
}