//
//  ViewController.swift
//  InDoor-Admin
//
//  Created by Alaa on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var brandsCollection: UICollectionView!
    var homeViewModel = HomeViewModel(network: ApiHandler())
    var networkIndicator:UIActivityIndicatorView!
    var brands:[SmartCollections] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadIndicator()
        getBrands()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: Constants.cellClassName , bundle: nil)
        brandsCollection.register(nib, forCellWithReuseIdentifier: Constants.cellName)
    }
    
    func loadIndicator(){
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.center = self.view.center
        self.view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    func getBrands(){
        homeViewModel.getAvailableBrands { [weak self] brandArr in
            self?.brands = brandArr
            self?.brandsCollection.reloadData()
            self?.networkIndicator.stopAnimating()
        }
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellName, for: indexPath) as! BrandsCollectionViewCell
        cell.setBrandData(brand: brands[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 32, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-16, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionProducts = self.storyboard?.instantiateViewController(identifier: Constants.collectionProductsStroyBoardName) as! CollectionProductsViewController
        collectionProducts.brand = brands[indexPath.row]
        self.navigationController?.pushViewController(collectionProducts, animated: true)
    }
}

extension ViewController{
    class Constants{
        static var cellName = "brandsCell"
        static var cellClassName = "BrandsCollectionViewCell"
        static var collectionProductsStroyBoardName = "collectionProducts"
    }
}

