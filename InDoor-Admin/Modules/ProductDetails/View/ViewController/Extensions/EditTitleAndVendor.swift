//
//  EditTitleAndVendor.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController {
    
    @IBAction func editTitleAndVendor(_ sender: Any) {
        curtainView.isHidden = false
        titleAndVendorOverlayView.isHidden = false
        titleAndVendorOverlayView.giveShadowAndRadius(shadowRadius: 5, cornerRadius: 20)
        titleEditText.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        titleEditText.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        titleEditText.text = product.title
        vendorEditText.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        vendorEditText.setRightPaddingPoints(8)
        vendorEditText.setLeftPaddingPoints(8)
        vendorEditText.text = product.vendor
        typeEditText.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        typeEditText.setRightPaddingPoints(8)
        typeEditText.setLeftPaddingPoints(8)
        typeEditText.text = product.productType
    }
    
    @IBAction func doneEditingTitleAndVendor(_ sender: Any) {
        if titleEditText.text!.isEmpty || vendorEditText.text!.isEmpty || typeEditText.text!.isEmpty {
            presentAlert(title: "Error", message: "Please Fill All Fields")
        }else{
            product.title = titleEditText.text
            product.vendor = vendorEditText.text
            product.productType = typeEditText.text
            initializeUI()
            titleAndVendorOverlayView.isHidden = true
            curtainView.isHidden = true
        }
    }
    @IBAction func exitEditingTitleAndVendor(_ sender: Any) {
        titleAndVendorOverlayView.isHidden = true
        curtainView.isHidden = true
    }
}
