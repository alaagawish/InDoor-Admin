//
//  ViewController.swift
//  InDoor-Admin
//
//  Created by Alaa on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var brandsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: "BrandsCollectionViewCell" , bundle: nil)
        brandsCollection.register(nib, forCellWithReuseIdentifier: "brandsCell")
    }
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath) as! BrandsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 32, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-16, height: collectionView.frame.height/4)
    }
}

