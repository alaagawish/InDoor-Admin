//
//  EditPrice.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit

extension ProductDetailsViewController{
    
    @IBAction func editPrice(_ sender: Any) {
        if selectedSize == nil || selectedColor == nil {
            presentAlert(title: "Notice", message: "Please select color and size first")
        }else{
            if editPriceTextField.isHidden {
                editPriceTextField.isHidden = false
                editPriceButton.setImage(UIImage(systemName: "checkmark.diamond.fill"), for: .normal)
            }else{
                if editPriceTextField.text!.isEmpty {
                    editPriceTextField.isHidden = true
                    editPriceButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
                }else{
                    if Double(editPriceTextField.text ?? "") != nil {
                        if Double(editPriceTextField.text!) == 0.0 {
                            presentAlert(title: "Error", message: "Price Can't be set to zero")
                        }else{
                            editPriceTextField.isHidden = true
                            editPriceButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
                            let variantName = "\(selectedSize!) / \(selectedColor!)"
                            for variant in product.variants!.indices{
                                if product.variants![variant].title! == variantName{
                                    product.variants![variant].price = editPriceTextField.text
                                    price.text = "\(product.variants![variant].price!)$"
                                    editPriceTextField.text = ""
                                }
                            }
                        }
                    }else{
                        presentAlert(title: "Error", message: "Please enter valid Price")
                    }
                }
            }
        }
    }
    
}
