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
