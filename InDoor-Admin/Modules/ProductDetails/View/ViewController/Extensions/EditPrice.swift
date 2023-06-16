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
            InstructionAlert.presentAlert(vc: self, title: Constants.notice, message: Constants.selectSizeAndColor)
        }else{
            if editPriceTextField.isHidden {
                editPriceTextField.isHidden = false
                editPriceButton.setImage(UIImage(systemName: Constants.checkMarkDiamondImage), for: .normal)
            }else{
                if editPriceTextField.text!.isEmpty {
                    editPriceTextField.isHidden = true
                    editPriceButton.setImage(UIImage(systemName: Constants.pencilEditImage), for: .normal)
                }else{
                    if Double(editPriceTextField.text ?? "") != nil {
                        if Double(editPriceTextField.text!) == 0.0 {
                            InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.zeroPrice)
                        }else{
                            editPriceTextField.isHidden = true
                            editPriceButton.setImage(UIImage(systemName: Constants.pencilEditImage), for: .normal)
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
                        InstructionAlert.presentAlert(vc: self, title: Constants.error, message: Constants.validPrice)
                    }
                }
            }
        }
    }
    
}
