//
//  DeleteAlerts.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController {
    // Delete Alerts
    func showDeleteAlert(index: Int){
        let alert = UIAlertController(title: Constants.warning, message: Constants.deleteVariantInsteadOfZero, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
            if((self.product.variants!.count) > 1){
                let sizeInQuestion = self.product.variants?[index].option1
                let colorInQuestion = self.product.variants?[index].option2
                self.product.variants?.remove(at: index)
                self.checkOtherOptions(sizeOption: sizeInQuestion!, colorOption: colorInQuestion!)
            }else{
                self.showDeletetProductAlert()
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .default)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func showDeletetProductAlert(){
        let alert = UIAlertController(title: Constants.warning, message: Constants.deleteProductInsteadOfVariant, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: Constants.delete, style: .destructive) { [weak self] _ in
            self?.productDetailsViewModel.deleteProduct(product: (self?.product)!)
            self?.animateDone()
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .default)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func checkOtherOptions(sizeOption: String, colorOption: String){
        var shouldDeleteSizeOption = true
        var shouldDeleteColorOption = true
        for variant in product.variants! {
            if variant.option1 == sizeOption {
                shouldDeleteSizeOption = false
            }
            if variant.option2 == colorOption {
                shouldDeleteColorOption = false
            }
            if shouldDeleteSizeOption == false && shouldDeleteColorOption == false {
                break
            }
        }
        if shouldDeleteSizeOption {
            for index in product.options![0].values!.indices {
                if product.options![0].values![index] == sizeOption{
                    product.options![0].values?.remove(at: index)
                    break
                }
            }
        }
        if shouldDeleteColorOption {
            for index in product.options![1].values!.indices {
                if product.options![1].values![index] == colorOption{
                    product.options![1].values?.remove(at: index)
                    break
                }
            }
        }
        initializeUI()
        price.text = Constants.selectSize
        stockCount.text = Constants.selectSize
        selectedSize = nil
        selectedColor = nil
        sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
    }
}

