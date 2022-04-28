//
//  HomeViewController.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myTitle = [ "All","Men" , "Women" , "Kids"]
    var mySubCategory = ["All" , "Sell" , "Fasion" ,  "Mobile Phone" , "electronics"]
    var products: [Product] = []
    
    var lastIndexActive:IndexPath = [1 ,0]
    var lastIndexActive2:IndexPath = [1,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillStaticData()
        setUpCollectionsViews()
    }
    
    func setUpCollectionsViews(){
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductInCell")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
    }
    
    func fillStaticData(){
        products.append(Product(name: "iPhone Cover", image: "2", price: "120"))
        products.append(Product(name: "TCL Wireless", image: "3", price: "1200"))
        products.append(Product(name: "USB Type-C", image: "4", price: "30"))
        products.append(Product(name: "Sneakers", image: "5", price: "1500"))
        products.append(Product(name: "Vegas V2101", image: "6", price: "900"))
        products.append(Product(name: " UV400 Retro Metal", image: "7", price: "1200"))
        products.append(Product(name: "TCL MTRO200BT", image: "8", price: "650"))
        products.append(Product(name: "Anker 622", image: "9", price: "129"))
        products.append(Product(name: "pak Extreme ", image: "10", price: "190"))
        products.append(Product(name: "Kitchen appliances", image: "1", price: "12.000"))
    }
}

extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: self.view.frame.width*0.43, height: self.view.frame.width*0.6)
        }else if collectionView == self.categoriesCollectionView{
            return CGSize(width: self.view.frame.width*0.29, height: self.view.frame.width*0.6)
        }else{
            return CGSize(width: self.view.frame.width*0.23, height: self.view.frame.width*0.6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return products.count
        }else if collectionView == self.categoriesCollectionView {
            return myTitle.count
        }else {
            return mySubCategory.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInCell", for: indexPath) as! ProductCollectionViewCell
            
            cell.nameLabel.text = products[indexPath.row].name
            cell.PriceLabel.text = products[indexPath.row].price
            cell.productImageView.image = UIImage(named: products[indexPath.row].image ?? "1")
            return cell
            
        }else if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath as IndexPath) as! CategoriesCollectionViewCell
            
            cell.nameLabel.text = self.myTitle[indexPath.row]
            cell.viewCell.layer.cornerRadius = 20
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoriesCollectionViewCell", for: indexPath as IndexPath) as! SubcategoriesCollectionViewCell
            
            cell.subCategoryName.text = self.mySubCategory[indexPath.row]
            return cell
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.categoriesCollectionView {
            if self.lastIndexActive != indexPath {
                
                let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
                cell.nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.viewCell.backgroundColor = #colorLiteral(red: 0.9194818139, green: 0.316909492, blue: 0.2418158352, alpha: 0.8284669586)
                
                let cell1 = collectionView.cellForItem(at: self.lastIndexActive) as? CategoriesCollectionViewCell
                cell1?.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell1?.viewCell.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
                self.lastIndexActive = indexPath
            }
        }
    }
}
