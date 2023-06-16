//
//  addImage.swift
//  InDoor-Admin
//
//  Created by Ahmed on 15/06/2023.
//

import UIKit

//=================================================================================
extension AddProductViewController {
    
    // second page logic
    
    func setSecondPageUI(){
        addImageUrlTextField.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        addImageUrlTextField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    @IBAction func loadImage(_ sender: Any) {
        if addImageUrlTextField.text != "" {
            addImageImageView.kf.setImage(with: URL(string: addImageUrlTextField.text))
        }else{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterImageURL)
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        if saveProductImage(){
            addImageUrlTextField.text = ""
        }
    }
    
    func saveProductImage() -> Bool{
        if addImageUrlTextField.text != ""{
            var duplicatedImage = false
            if !product.images!.isEmpty {
                for image in product.images! {
                    if image.src == addImageUrlTextField.text {
                        duplicatedImage = true
                        break
                    }
                }
            }
            if duplicatedImage {
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.duplicatedImage)
                return false
            }else{
                product.images?.append(Image(src: addImageUrlTextField.text))
                return true
            }
        }else{
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterImageURL)
            return false
        }
    }
    
    func checkAndMoveToVariantPage(){
        if addImageUrlTextField.text == "" {
            if product.images!.isEmpty {
                InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.atLeastOneImage)
            }else {
                moveToVariantPage()
            }
        }else{
            var duplicatedImage = false
            for image in product.images! {
                if image.src == addImageUrlTextField.text {
                    duplicatedImage = true
                    break
                }
            }
            if duplicatedImage {
                moveToVariantPage()
            }else{
                showImageHandlingAlert()
            }
        }
    }
    
    func showImageHandlingAlert(){
        let alert = UIAlertController(title: Constants.warning, message: Constants.imageHandlingQuery, preferredStyle: .alert)
        let actionSaveAndContinue = UIAlertAction(title: Constants.save, style: .default) { _ in
            self.product.images?.append(Image(src: self.addImageUrlTextField.text))
            self.moveToVariantPage()
        }
        let actionDiscardAndContinue = UIAlertAction(title: Constants.discard, style: .destructive) { _ in
            self.moveToVariantPage()
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(actionSaveAndContinue)
        alert.addAction(actionDiscardAndContinue)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func moveToVariantPage(){
        self.currentPage += 1
        self.ImageInputView.isHidden = true
        self.variantInputView.isHidden = false
        self.nextButton.setImage(UIImage(systemName: Constants.checkMarkSeal), for:.normal)
        self.addImageUrlTextField.text = ""
    }
}

