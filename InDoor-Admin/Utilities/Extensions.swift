//
//  Extensions.swift
//  InDoor-Admin
//
//  Created by Ahmed on 13/06/2023.
//

import UIKit

extension UIView {
    func giveShadowAndRadius(scale: Bool = true, shadowRadius:Int, cornerRadius:Int) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = .zero
        layer.shadowRadius = CGFloat(integerLiteral: shadowRadius)
        layer.shouldRasterize = true
        layer.cornerRadius = CGFloat(integerLiteral: cornerRadius)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

extension UICollectionViewCell {
    func elevateCellAndRemoveBorder (){
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    func addBorderAndRemoveShadow (){
        layer.shadowRadius = 0.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.0
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = UIColor(named: "Pinkish")?.cgColor
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}
extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime])
}
extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}
