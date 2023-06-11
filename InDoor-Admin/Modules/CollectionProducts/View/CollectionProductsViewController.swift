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
    var products:[Product] = []{
        didSet{
            if products.count == responseCount{
                collectionProductsTable.reloadData()
            }
        }
    }
    var brand:SmartCollections!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
        getProducts()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: Constants.cellClassName , bundle: nil)
        collectionProductsTable.register(nib, forCellReuseIdentifier: Constants.cellName)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getProducts(){
        collectionProductsViewModel.getPrdouctsOfSpecificBrand(brandID: String(brand.id)) { [weak self] productsArr in
            self?.responseCount = productsArr.count
            for product in productsArr {
                self?.collectionProductsViewModel.getSpecificProduct(productID: String(product.id)) { product in
                    self?.products.append(product)
                }
            }
        }
    }
}

extension CollectionProductsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName) as! ProductsTableViewCell
        cell.setProductData(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsVC = self.storyboard?.instantiateViewController(identifier:Constants.detailsScreenName) as! ProductDetailsViewController
        productDetailsVC.product = products[indexPath.row]
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
}

extension CollectionProductsViewController{
    class Constants{
        static var cellName = "ProductTableViewCell"
        static var cellClassName = "ProductsTableViewCell"
        static var tableHeight = 200.0
        static var detailsScreenName = "productDetails"
    }
}
