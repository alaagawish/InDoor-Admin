//
//  AddProductViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 14/06/2023.
//

import UIKit
import Kingfisher

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var variantInputView: UIView!
    @IBOutlet weak var ImageInputView: UIView!
    @IBOutlet weak var addImageUrlTextField: UITextView!
    @IBOutlet weak var addImageImageView: UIImageView!
    @IBOutlet weak var titleInputView: UIView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var vendorTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var pageIndicator: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var brand:SmartCollections!
    var allProducts: [Product] = []
    var optionArr = [Options(name: Constants.size, position: 1, values: []),Options(name: Constants.color, position: 2, values: [])]
    var product: Product!
    var currentPage = 1{
        didSet{
            pageIndicator.text = "\(currentPage)/3"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAddProductUI()
    }
    
    func initializeAddProductUI(){
        product = Product( id: nil, title: "", bodyHtml: "", vendor: "", productType: "", createdAt: nil, handle: nil, updatedAt: nil, publishedAt: nil, status: nil, publishedScope: nil, tags: nil, adminGraphqlApiId: nil, variants: [], options: optionArr, images: [], image: nil)
        if brand != nil {
            vendorTextField.isEnabled = false
            vendorTextField.text = brand.title
        }
        setFirstPageUI()
        setSecondPageUI()
        setThirdPageUI()
    }
}
