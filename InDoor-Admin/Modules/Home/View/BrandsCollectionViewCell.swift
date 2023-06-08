//
//  BrandsCollectionViewCell.swift
//  InDoor-Admin
//
//  Created by Ahmed on 04/06/2023.
//

import UIKit
import Kingfisher

class BrandsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var brandImage: UIImageView!
    
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
}
