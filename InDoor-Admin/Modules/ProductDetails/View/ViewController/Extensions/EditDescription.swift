//
//  EditDescription.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController {

    @IBAction func editDescription(_ sender: Any) {
        descriptionOverlayView.isHidden = false
        curtainView.isHidden = false
        descriptionEditText.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        descriptionOverlayView.giveShadowAndRadius(shadowRadius: 5, cornerRadius: 20)
        descriptionEditText.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        descriptionEditText.text = product.bodyHtml
    }
    
    @IBAction func closeDescriptionEditBox(_ sender: Any) {
        descriptionOverlayView.isHidden = true
        curtainView.isHidden = true
    }
    
    @IBAction func doneEdititingDescription(_ sender: Any) {
        if descriptionEditText.text!.isEmpty {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.emptyDescription)
        }else{
            product.bodyHtml = descriptionEditText.text
            descriptionOverlayView.isHidden = true
            curtainView.isHidden = true
            initializeUI()
        }
    }
}
