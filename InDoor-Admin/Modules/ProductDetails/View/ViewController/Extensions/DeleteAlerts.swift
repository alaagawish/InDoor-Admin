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
        let alert = UIAlertController(title: "Warning", message: "Quantity set to zero do you want to delete this variant instead?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if((self.product.variants!.count) > 1){
                let sizeInQuestion = self.product.variants?[index].option1
                let colorInQuestion = self.product.variants?[index].option2
                self.product.variants?.remove(at: index)
//                for sizeIndex in self.product.options![0].values!.indices{
//                    if self.product.options![0].values![sizeIndex] == self.selectedSize {
//                        self.sizeCollectionHandler.collectionView(self.sizeCollectionView, didDeselectItemAt: IndexPath(row: sizeIndex, section: 0))
//                        break
//                    }
//                }
//                for colorIndex in self.product.options![1].values!.indices{
//                    if self.product.options![1].values![colorIndex] == self.selectedColor{
//                        self.colorCollectionHandler.collectionView(self.colorCollectionView, didDeselectItemAt: IndexPath(row: colorIndex, section: 0))
//                        break
//                    }
//                }
//                self.selectedSize = nil
//                self.selectedColor = nil
//                self.price.text = "Select Options"
//                self.stockCount.text = "Select Options"
                self.checkOtherOptions(sizeOption: sizeInQuestion!, colorOption: colorInQuestion!)
            }else{
                self.showDeletetProductAlert()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func showDeletetProductAlert(){
        let alert = UIAlertController(title: "Warning", message: "Deleting the last vatiant will delete the whole product\n are you sure you want to delete the product ?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
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
        price.text = "Select Size"
        stockCount.text = "Select Size"
        selectedSize = nil
        selectedColor = nil
        sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
    }
}

