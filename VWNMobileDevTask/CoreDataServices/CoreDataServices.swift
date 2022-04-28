//
//  CoreDataServices.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataServices {
    static let shared = CoreDataServices()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension CoreDataServices{
    func addNewProduct(complition: @escaping (Bool)->Void){
        do{
            try self.context.save()
            complition(true)
        }catch{
            print("Error in addNewProduct", error.localizedDescription)
            complition(false)
        }
    }
}

extension CoreDataServices{
    func getAllProduct(complition: @escaping ([ProductModel]?, Error?)-> Void){
        do{
            let leagues = try self.context.fetch(ProductModel.fetchRequest())
            complition(leagues, nil)
       }catch{
            complition(nil, error)
            print("Error in getAllProduct function: ", error.localizedDescription)
        }
    }
}

extension CoreDataServices{
    func deletedSelectedProduct(product: ProductModel, complition: @escaping (Bool) -> Void){
        self.context.delete(product)
        do{
            try self.context.save()
            complition(true)
        }catch{
            print("Error when delete product: ", error.localizedDescription)
            complition(false)
        }
    }
}

