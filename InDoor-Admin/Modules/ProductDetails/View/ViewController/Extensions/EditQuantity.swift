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
            presentAlert(title: "Notice", message: "Please select color and size first")
        }else{
            if editQuantityTextField.isHidden {
                editQuantityTextField.isHidden = false
                editQuantityButton.setImage(UIImage(systemName: "checkmark.diamond.fill"), for: .normal)
            }else{
                if editQuantityTextField.text!.isEmpty {
                    editQuantityTextField.isHidden = true
                    editQuantityButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
                }else{
                    if Int(editQuantityTextField.text ?? "") != nil {
                        editQuantityTextField.isHidden = true
                        editQuantityButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
                        let variantName = "\(selectedSize!) / \(selectedColor!)"
                        for variant in product.variants!.indices{
                            if product.variants![variant].title! == variantName{
                                product.variants![variant].inventoryQuantity = Int(editQuantityTextField.text!)
                                if Int(editQuantityTextField.text!) == 0 {
                                    showDeleteAlert(index: variant)
                                    stockCount.text = "Not Available"
                                }else{
                                    stockCount.text = "\(product.variants![variant].inventoryQuantity!) in stock"
                                }
                                editQuantityTextField.text = ""
                            }
                        }
                    }else{
                        presentAlert(title: "Error", message: "Please enter valid number")
                    }
                }
            }
        }
    }
}
