//
//  AllProductsViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 09/06/2023.
//

import UIKit

class AllProductsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var allProductsTable: UITableView!
    var allProductsViewModel = AllProductsViewModel(network: ApiHandler())
    var products:[Product] = []
    var filteredProducts:[Product] = []
    var searching = false
    var networkIndicator:UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
        addProductButton.giveShadowAndRadius(shadowRadius: 7, cornerRadius: 25)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadIndicator()
        searchTextField.text = ""
        searchTextField.layer.cornerRadius = 20
        searching = false
        getProducts()
    }
    
    func loadIndicator(){
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.center = self.view.center
        self.view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: AllProductsConstants.cellClassName , bundle: nil)
        allProductsTable.register(nib, forCellReuseIdentifier: AllProductsConstants.cellName)
    }
    
    func getProducts(){
        allProductsViewModel.getAllProducts(completionHandler: {[weak self] allProducts in
            self?.products = allProducts
            self?.networkIndicator.stopAnimating()
            self?.allProductsTable.reloadData()
        })
    }
    
    @IBAction func typingASearchWord(_ sender: Any) {
        if searchTextField.text! == "" {
            searching = false
            allProductsTable.reloadData()
        }else{
            searching = true
            filteredProducts = []
            for product in products {
                if product.title!.contains(searchTextField.text!){
                    filteredProducts.append(product)
                }
            }
            allProductsTable.reloadData()
        }
    }
    @IBAction func goToAddProductPage(_ sender: Any) {
        let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: "addProduct") as! AddProductViewController
        addProductVC.allProducts = products
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
}

extension AllProductsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredProducts.count
        }else{
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllProductsConstants.cellName) as! ProductsTableViewCell
        if searching {
            cell.setProductData(product: filteredProducts[indexPath.row])
        }else{
            cell.setProductData(product: products[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AllProductsConstants.tableHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsVC = self.storyboard?.instantiateViewController(identifier:AllProductsConstants.detailsScreenName) as! ProductDetailsViewController
        if searching {
            productDetailsVC.product = filteredProducts[indexPath.row]
        }else{
            productDetailsVC.product = products[indexPath.row]
        }
        productDetailsVC.newProduct = false
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: Constants.warning, message: Constants.confirmDeleteProduct, preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: Constants.delete, style: .destructive) { _ in
            if self.searching {
                self.allProductsViewModel.deleteProduct(product: self.filteredProducts[indexPath.row])
                for productIndex in self.products.indices {
                    if self.products[productIndex].id == self.filteredProducts[indexPath.row].id {
                        self.products.remove(at: productIndex)
                    }
                }
                self.filteredProducts.remove(at: indexPath.row)
            }else{
                self.allProductsViewModel.deleteProduct(product: self.products[indexPath.row])
                self.products.remove(at: indexPath.row)
            }
            self.allProductsTable.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
}

extension AllProductsViewController{
    class AllProductsConstants{
        static var cellName = "ProductTableViewCell"
        static var cellClassName = "ProductsTableViewCell"
        static var tableHeight = 200.0
        static var detailsScreenName = "productDetails"
    }
}
