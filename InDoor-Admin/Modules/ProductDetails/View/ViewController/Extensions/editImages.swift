//
//  editImages.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController{
    // Image Editing
    @IBAction func exitImageEditing(_ sender: Any) {
        editImageOverlayView.isHidden = true
        curtainView.isHidden = true
        editImageUrl.text = ""
        editImageImageView.kf.setImage(with: URL(string: ""))
    }
    
    @IBAction func showImage(_ sender: Any) {
        if editImageUrl.text!.isEmpty {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterImageURL)
        }else{
            editImageImageView.kf.setImage(with: URL(string: editImageUrl.text))
        }
    }
    
    @IBAction func saveImage(_ sender: Any) {
        if editImageUrl.text!.isEmpty {
            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterImageURL)
        }else{
                if addImageOrEdit == Constants.add {
                product.images?.append(Image(src: editImageUrl.text))
            }else{
                imagesToDelete.append((product.images?[selectedImageIndex])!)
                product.images?[selectedImageIndex].src = editImageUrl.text
                product.images?[selectedImageIndex].id = nil
                product.images?[selectedImageIndex].updatedAt = nil
                product.images?[selectedImageIndex].createdAt = nil
            }
            editImageOverlayView.isHidden = true
            editImageUrl.text = ""
            editImageImageView.kf.setImage(with: URL(string: ""))
            curtainView.isHidden = true
            productImagesArr = []
            prepareProductImagesArr()
            initializeUI()
        }
    }
    
    @IBAction func addAnotherImage(_ sender: Any) {
        editImageOverlayView.isHidden = false
        curtainView.isHidden = false
        editImageOverlayView.giveShadowAndRadius(shadowRadius: 5, cornerRadius: 20)
        editImageUrl.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        editImageUrl.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        addImageOrEdit = Constants.add
        deleteImageButton.isHidden = true
    }
    
    @IBAction func selectSpecificImage(_ sender: Any) {
        selectedImageIndex = productImagesSlider.currentPage
        editImageOverlayView.isHidden = false
        curtainView.isHidden = false
        editImageOverlayView.giveShadowAndRadius(shadowRadius: 5, cornerRadius: 20)
        editImageUrl.giveShadowAndRadius(shadowRadius: 0, cornerRadius: 20)
        editImageUrl.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        editImageUrl.text = product.images?[productImagesSlider.currentPage].src
        editImageImageView.kf.setImage(with: URL(string: product.images?[productImagesSlider.currentPage].src ?? ""))
        addImageOrEdit = Constants.edit
        deleteImageButton.isHidden = false
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        let alert = UIAlertController(title: Constants.warning, message: Constants.confirmDeleteImage, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
            self.imagesToDelete.append((self.product.images?[self.selectedImageIndex])!)
            self.product.images?.remove(at: self.selectedImageIndex)
            self.exitImageEditing((Any).self)
            self.productImagesArr = []
            self.prepareProductImagesArr()
            self.initializeUI()
        }
        let actionCancel = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
    
}
