//
//  CollectionProductsViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import UIKit

class CollectionProductsViewController: UIViewController {

    var responseCount:Int = .zero
    @IBOutlet weak var collectionProductsTable: UITableView!
    var collectionProductsViewModel = CollectionProductsViewModel(network: ApiHandler())
    var networkIndicator: UIActivityIndicatorView!
    var products:[Product] = []{
        didSet{
            if products.count == responseCount{
                collectionProductsTable.reloadData()
                networkIndicator.stopAnimating()
            }
        }
    }
    var brand:SmartCollections!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator()
        setupNibCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProducts()
    }
    
    func loadIndicator(){
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.center = self.view.center
        self.view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: CollectionProductsConstants.cellClassName , bundle: nil)
        collectionProductsTable.register(nib, forCellReuseIdentifier: CollectionProductsConstants.cellName)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getProducts(){
        collectionProductsViewModel.getPrdouctsOfSpecificBrand(brandID: String(brand.id)) { [weak self] productsArr in
            self?.responseCount = productsArr.count
            for product in productsArr {
                self?.collectionProductsViewModel.getSpecificProduct(productID: String(product.id!)) { product in
                    self?.products.append(product)
                }
            }
        }
    }
    @IBAction func addProductToCollection(_ sender: Any) {
        let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: "addProduct") as! AddProductViewController
        addProductVC.brand = brand
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
}

extension CollectionProductsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionProductsConstants.cellName) as! ProductsTableViewCell
        cell.setProductData(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CollectionProductsConstants.tableHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsVC = self.storyboard?.instantiateViewController(identifier:CollectionProductsConstants.detailsScreenName) as! ProductDetailsViewController
        productDetailsVC.product = products[indexPath.row]
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: Constants.warning, message: Constants.confirmDeleteProduct, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
            self.collectionProductsViewModel.deleteProduct(product: self.products[indexPath.row])
            self.products.remove(at: indexPath.row)
            self.collectionProductsTable.reloadData()
        }
        let actionCancel = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
}

extension CollectionProductsViewController{
    class CollectionProductsConstants{
        static var cellName = "ProductTableViewCell"
        static var cellClassName = "ProductsTableViewCell"
        static var tableHeight = 200.0
        static var detailsScreenName = "productDetails"
    }
}
