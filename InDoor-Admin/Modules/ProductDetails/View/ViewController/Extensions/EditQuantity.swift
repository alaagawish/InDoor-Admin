//
//  EditQuantity.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController{

    @IBAction func editQuantity(_ sender: Any) {
        if selectedSize == nil || selectedColor == nil {
            InstructionAlert.presentAlert(vc: self, title: Constants.notice, message: Constants.selectSizeAndColor)
        }else{
            if editQuantityTextField.isHidden {
                editQuantityTextField.isHidden = false
                editQuantityButton.setImage(UIImage(systemName: Constants.checkMarkDiamondImage), for: .normal)
            }else{
                if editQuantityTextField.text!.isEmpty {
                    editQuantityTextField.isHidden = true
                    editQuantityButton.setImage(UIImage(systemName: Constants.pencilEditImage), for: .normal)
                }else{
                    if Int(editQuantityTextField.text ?? "") != nil {
                        editQuantityTextField.isHidden = true
                        editQuantityButton.setImage(UIImage(systemName: Constants.pencilEditImage), for: .normal)
                        let variantName = "\(selectedSize!) / \(selectedColor!)"
                        for variant in product.variants!.indices{
                            if product.variants![variant].title! == variantName{
                                product.variants![variant].inventoryQuantity = Int(editQuantityTextField.text!)
                                product.variants![variant].oldInventoryQuantity = Int(editQuantityTextField.text!)
                                if Int(editQuantityTextField.text!) == 0 {
                                    showDeleteAlert(index: variant)
                                    stockCount.text = Constants.notAvailable
                                }else{
                                    stockCount.text = "\(product.variants![variant].inventoryQuantity!) \(Constants.inStock)"
                                }
                                editQuantityTextField.text = ""
                            }
                        }
                    }else{
                        InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.enterValidNumber)
                    }
                }
            }
        }
    }
}
