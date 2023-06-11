//
//  ProductsTableViewCell.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import UIKit
import Kingfisher

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var stockState: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override var frame: CGRect{
        get {
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.origin.y += 8
            frame.size.width -= 2 * 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    
    func setProductData(product: Product){
        productName.text = product.title
        productDescription.text = "\(product.vendor ?? ""), \(product.productType ?? "")"
        productPrice.text = (product.variants?[0].price ?? "")+"$"
        productImage.kf.setImage(with: URL(string: product.image?.src ?? ""))
        let stockAmount = calculateInventoryCount(product: product)
        if stockAmount > 0 {
            stockState.text = "\(stockAmount) In Stock"
        }else{
            stockState.text = "Not Available"
        }
        
    }
    
    func calculateInventoryCount(product: Product) -> Int{
        var totalInventoryCount = 0
        for variant in product.variants! {
            totalInventoryCount += variant.inventoryQuantity ?? 0
        }
        return totalInventoryCount
    }
}
