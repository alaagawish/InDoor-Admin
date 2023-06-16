//
//  ProductDetailsViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 10/06/2023.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher
import Cosmos
import Lottie

class ProductDetailsViewController: UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var doneAnimation: LottieAnimationView!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var saveProductButton: UIButton!
    @IBOutlet weak var deleteImageButton: UIButton!
    @IBOutlet weak var addVariantOverlayView: UIView!
    @IBOutlet weak var addVariantQuantityTextField: UITextField!
    @IBOutlet weak var addVariantPriceTextField: UITextField!
    @IBOutlet weak var addVariantColorTextField: UITextField!
    @IBOutlet weak var addVariantSizeTextField: UITextField!
    @IBOutlet weak var editImageUrl: UITextView!
    @IBOutlet weak var editImageImageView: UIImageView!
    @IBOutlet weak var editImageOverlayView: UIView!
    @IBOutlet weak var titleAndVendorOverlayView: UIView!
    @IBOutlet weak var typeEditText: UITextField!
    @IBOutlet weak var vendorEditText: UITextField!
    @IBOutlet weak var titleEditText: UITextView!
    @IBOutlet weak var curtainView: UIView!
    @IBOutlet weak var descriptionEditText: UITextView!
    @IBOutlet weak var descriptionOverlayView: UIView!
    @IBOutlet weak var editPriceButton: UIButton!
    @IBOutlet weak var editQuantityButton: UIButton!
    @IBOutlet weak var editQuantityTextField: UITextField!
    @IBOutlet weak var editPriceTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productVendorAndType: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImagesSlider: ImageSlideshow!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    var newProduct = false
    var productImagesArr: [InputSource] = []
    var imagesToDelete:[Image] = []
    var product:Product!
    var addImageOrEdit = ""
    var selectedImageIndex = -1
    var sizeCollectionHandler = ProductSizeCollectionDelegatesHandling()
    var colorCollectionHandler = ProductColorCollectionDelegatesHandling()
    var productDetailsViewModel = ProductDetailsViewModel(network: ApiHandler())
    var selectedSize: String!{
        didSet{
            var tempColorArr:[String] = []
            for variant in product.variants! {
                if variant.option1 == selectedSize{
                    tempColorArr.append(variant.option2!)
                }
            }
            colorCollectionHandler.colorArr = tempColorArr
            colorCollectionView.reloadData()
            if selectedSize != nil{
                price.text = Constants.selectColor
                stockCount.text = Constants.selectColor
            }
        }
    }
    var selectedColor: String!{
        didSet{
            checkPriceAndAvailability()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareProductImagesArr()
        initializeUI()
    }
    
    func animateDone(){
        doneAnimation.isHidden = false
        doneAnimation.contentMode = .scaleAspectFit
        doneAnimation.loopMode = .playOnce
        doneAnimation.play { done in
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func prepareProductImagesArr(){
        for image in product.images!{
            productImagesArr.append(KingfisherSource(url: URL(string: image.src ?? "")!))
        }
    }
    
    func initializeUI(){
        saveProductButton.giveShadowAndRadius(shadowRadius: 10, cornerRadius: 10)
        rating.rating = Double(product.templateSuffix ?? "1.5") ?? 1.5
        prepareSizeCollection()
        prepareColorCollection()
        startSlider()
        productName.text = product.title
        productVendorAndType.text = "\(product.vendor ?? ""), \(product.productType ?? "")"
        descriptionLabel.text = product.bodyHtml
        sizeCollectionView.reloadData()
        colorCollectionView.reloadData()
    }
    
    func prepareSizeCollection(){
        sizeCollectionHandler.viewController = self
        sizeCollectionView.dataSource = sizeCollectionHandler
        sizeCollectionView.delegate = sizeCollectionHandler
        sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
    }
    
    func prepareColorCollection(){
        colorCollectionHandler.viewController = self
        colorCollectionView.dataSource = colorCollectionHandler
        colorCollectionView.delegate = colorCollectionHandler
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
    }
    
    func startSlider(){
        productImagesSlider.slideshowInterval = 3.5
        productImagesSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        productImagesSlider.isUserInteractionEnabled = true
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        productImagesSlider.pageIndicator = pageControl
        productImagesSlider.activityIndicator = DefaultActivityIndicator()
        productImagesSlider.delegate = self
        productImagesSlider.setImageInputs(productImagesArr)
        
    }
    
    func checkPriceAndAvailability(){
        var foundVariant = false
        if selectedSize == nil || selectedColor == nil {}
        else{
            for variant in product.variants!{
                let variantName = "\(selectedSize!) / \(selectedColor!)"
                if variant.title! == variantName{
                    foundVariant = true
                    price.text = "\(variant.price!)$"
                    if variant.inventoryQuantity == nil || variant.inventoryQuantity == 0 {
                        stockCount.text = Constants.notAvailable
                    }else{
                        stockCount.text = "\(variant.inventoryQuantity!) \(Constants.inStock)"
                    }
                    return
                }
            }
            if foundVariant == false {
                price.text = Constants.selectOptions
                stockCount.text = Constants.selectOptions
                selectedSize = nil
                selectedColor = nil
                sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
                colorCollectionHandler.colorArr = product.options?[1].values ?? []
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveProduct(_ sender: Any) {
        product.templateSuffix = String(rating.rating)
        if newProduct{
            productDetailsViewModel.addProduct(product: product)
        }else{
            productDetailsViewModel.updateProduct(product: product, imagesToDelete: imagesToDelete)
        }
        animateDone()
    }
}
