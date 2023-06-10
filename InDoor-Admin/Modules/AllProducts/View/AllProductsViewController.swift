//
//  AllProductsViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 09/06/2023.
//

import UIKit

class AllProductsViewController: UIViewController {

    @IBOutlet weak var allProductsTable: UITableView!
    var allProductsViewModel = AllProductsViewModel(network: ApiHandler())
    var products:[Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
        getProducts()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: Constants.cellClassName , bundle: nil)
        allProductsTable.register(nib, forCellReuseIdentifier: Constants.cellName)
    }
    
    func getProducts(){
        allProductsViewModel.getAllProducts(completionHandler: {[weak self] allProducts in
            self?.products = allProducts
            self?.allProductsTable.reloadData()
        })
    }
}

extension AllProductsViewController:UITableViewDelegate,UITableViewDataSource{
    
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
}

extension AllProductsViewController{
    class Constants{
        static var cellName = "ProductTableViewCell"
        static var cellClassName = "ProductsTableViewCell"
        static var tableHeight = 170.0
    }
}
