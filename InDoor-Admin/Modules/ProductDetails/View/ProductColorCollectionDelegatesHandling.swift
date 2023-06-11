//
//  ProductColorCollectionDelegatesHandling.swift
//  InDoor-Admin
//
//  Created by Ahmed on 10/06/2023.
//

import Foundation

import UIKit

class ProductColorCollectionDelegatesHandling:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var colorArr:[String] = []
    var viewController:ProductDetailsViewController!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellName, for: indexPath) as! ColorCollectionViewCell
        cell.setData(color: colorArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4-16, height: collectionView.frame.width/4-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.shadowRadius = 0.0
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell?.layer.shadowOpacity = 0.0
        viewController.selectedColor = colorArr[indexPath.row]
        cell?.contentView.layer.borderWidth = 4
        cell?.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.shadowRadius = 5.0
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        cell?.layer.shadowOpacity = 0.7
        cell?.contentView.layer.borderWidth = 0
        cell?.contentView.layer.borderColor = UIColor.white.cgColor
    }
}

extension ProductColorCollectionDelegatesHandling{
    class Constants{
        static var cellName = "colorCollectionCell"
    }
}

