//
//  ProductModel+CoreDataProperties.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//
//

import Foundation
import CoreData


extension ProductModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductModel> {
        return NSFetchRequest<ProductModel>(entityName: "ProductModel")
    }

    @NSManaged public var productName: String?
    @NSManaged public var productPrice: String?
    @NSManaged public var productType: String?
    @NSManaged public var productInfo: String?
    @NSManaged public var productMeal: String?

}

extension ProductModel : Identifiable {

}
