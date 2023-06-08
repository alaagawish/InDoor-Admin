//
//  CollectionProductsViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 08/06/2023.
//

import UIKit

class CollectionProductsViewController: UIViewController {

    @IBOutlet weak var collectionProductsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: "ProductsTableViewCell" , bundle: nil)
        collectionProductsTable.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
    }
}

extension CollectionProductsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductsTableViewCell
        return cell
    }
}
