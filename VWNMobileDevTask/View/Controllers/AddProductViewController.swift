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
    var productsArray : [Product] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        productCollectionView.register(UINib(nibName: "AddProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddProductCollectionViewCell")
        self.hidenKeyboard()
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
    @IBAction func didPressedOnAddProduct(_ sender: UIButton) {
        addProductToList()
        addNewProduct()
    }
    
    @IBAction func didPressedOnDoneBtn(_ sender: UIButton) {
        self.animateButton(button: sender)
        addProductToList()
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
            }else{
                print("failed to add new product")
            }
        }
    }
    
    func addProductToList(){
        let newProduct = Product(name: productNameTextField.text, image: "")
        productsArray.append(newProduct)
        self.productCollectionView.reloadData()
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
        productsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductCollectionViewCell", for: indexPath) as! AddProductCollectionViewCell
        
        cell.removeProduct = {
            self.productsArray.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        
        cell.prodName.text = productsArray[indexPath.row].name
        
        return cell
    }
}
