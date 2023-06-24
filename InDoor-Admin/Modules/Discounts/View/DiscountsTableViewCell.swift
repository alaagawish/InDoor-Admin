//
//  DiscountsTableViewCell.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import UIKit

class DiscountsTableViewCell: UITableViewCell {

    @IBOutlet weak var discountUsage: UILabel!
    @IBOutlet weak var discountName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .white    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func setDiscountData(discount: DiscountCodes){
        discountName.text = discount.code
        discountUsage.text = String(discount.usageCount ?? 0)
    }
    
}
