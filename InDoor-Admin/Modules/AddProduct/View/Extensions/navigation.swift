//
//  navigation.swift
//  InDoor-Admin
//
//  Created by Ahmed on 15/06/2023.
//

import UIKit

extension AddProductViewController {
    // Navigation
    @IBAction func previousPage(_ sender: Any) {
        if currentPage == 3 {
            currentPage -= 1
            variantInputView.isHidden = true
            ImageInputView.isHidden = false
            nextButton.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for:.normal)

        }else if currentPage == 2{
            currentPage -= 1
            ImageInputView.isHidden = true
            titleInputView.isHidden = false
            previousButton.isHidden = true
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if currentPage == 1 {
            checkAndMoveToImagePage()
        }else if currentPage == 2 {
            checkAndMoveToVariantPage()
        }else {
            checkAndNavigateToDetails()
        }
    }
    
    func navigateToDetails(){
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "productDetails") as! ProductDetailsViewController
        detailsVC.product = product
        detailsVC.newProduct = true
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
        
    @IBAction func dismissAddProductScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
