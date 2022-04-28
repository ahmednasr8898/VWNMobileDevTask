//
//  AddProductViewController.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//
import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productInfoTextField: UITextField!
    @IBOutlet weak var productMealTextField: UITextField!
    @IBOutlet weak var itemTypeTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    var products: [ProductModel] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getAllProduct()
    }
    
    func setupCollectionView(){
        productCollectionView.register(UINib(nibName: "AddProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddProductCollectionViewCell")
        self.hidenKeyboard()
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
    @IBAction func didPressedOnAddProduct(_ sender: UIButton) {
        if valiedProductInfo() {
            addNewProduct()
        }else{
            self.showAlertError(title: "Erorr", message: "please fill correct info..")
        }
    }
    
    @IBAction func didPressedOnDoneBtn(_ sender: UIButton) {
        self.animateButton(button: sender)
        if valiedProductInfo() {
            addNewProduct()
        }else{
            self.showAlertError(title: "Erorr", message: "please fill correct info..")
        }
    }
    
    func getAllProduct(){
        CoreDataServices.shared.getAllProduct { products, error in
            guard let products = products else {return}
            self.products = products
            self.productCollectionView.reloadData()
        }
    }
    
    func addNewProduct(){
        let product = ProductModel(context: context)
        product.productName = productNameTextField.text
        product.productPrice = productPriceTextField.text
        product.productType = itemTypeTextField.text
        product.productInfo = productInfoTextField.text
        product.productMeal = productMealTextField.text
        CoreDataServices.shared.addNewProduct { success in
            if success {
                print("add new product success")
                self.getAllProduct()
                self.setupTextField()
            }else{
                print("failed to add new product")
            }
        }
    }
    
    func setupTextField(){
        productNameTextField.text = ""
        productInfoTextField.text = ""
        productMealTextField.text = ""
        productPriceTextField.text = ""
        itemTypeTextField.text = ""
    }
    
    func valiedProductInfo()-> Bool{
        guard let productName = productNameTextField.text, !productName.isEmpty, let productInfo = productInfoTextField.text, !productInfo.isEmpty, let productMeal = productMealTextField.text, !productMeal.isEmpty, let productPrice = productPriceTextField.text, !productPrice.isEmpty, let productType = itemTypeTextField.text, !productType.isEmpty else {
            return false
        }
        return true
    }
}

extension AddProductViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductCollectionViewCell", for: indexPath) as! AddProductCollectionViewCell

        cell.removeProduct = {
            let selectedProduct = self.products[indexPath.row]
            CoreDataServices.shared.deletedSelectedProduct(product: selectedProduct) { success in
                if success {
                    self.products.remove(at: indexPath.row)
                    self.productCollectionView.reloadData()
                }
            }
        }
        
        cell.prodName.text = products[indexPath.row].productName
        
        return cell
    }
}
