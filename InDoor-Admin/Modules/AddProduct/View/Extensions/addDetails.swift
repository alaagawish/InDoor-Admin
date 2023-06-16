//
//  addDetails.swift
//  InDoor-Admin
//
//  Created by Ahmed on 15/06/2023.
//

import UIKit

extension AddProductViewController {
    
    // first Page Logic
    
    func setFirstPageUI(){
        titleTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        titleTextField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        vendorTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        vendorTextField.setRightPaddingPoints(8)
        vendorTextField.setLeftPaddingPoints(8)
        typeTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        typeTextField.setRightPaddingPoints(8)
        typeTextField.setLeftPaddingPoints(8)
        descriptionTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        descriptionTextField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func checkAndMoveToImagePage(){
        if saveProductData(){
            currentPage += 1
            previousButton.isHidden = false
            nextButton.isHidden = false
            ImageInputView.isHidden = false
            titleInputView.isHidden = true
            variantInputView.isHidden = true
        }
    }
    
    func saveProductData() -> Bool{
        if firstPageFieldsAreEntered() {
            var isDuplicated = false
            for savedProduct in allProducts {
                if savedProduct.title == product.title{
                    isDuplicated = true
                    break
                }
            }
            if isDuplicated == false {
                product.title = titleTextField.text
                product.vendor = vendorTextField.text
                product.bodyHtml = descriptionTextField.text
                product.productType = typeTextField.text
                return true
            }else{
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.duplicatedProduct)
                return false
            }
        }else{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.emptyFields)
            return false
        }
    }
    
    func firstPageFieldsAreEntered() -> Bool{
        if titleTextField.text == "" || vendorTextField.text == "" || descriptionTextField.text == "" || typeTextField.text == "" {
            return false
        }else{
            return true
        }
    }
}
