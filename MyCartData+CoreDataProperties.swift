//
//  MyCartData+CoreDataProperties.swift
//  
//
//  Created by Ali Emre Değirmenci on 10.06.2019.
//
//

import Foundation
import CoreData


extension MyCartData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyCartData> {
        return NSFetchRequest<MyCartData>(entityName: "MyCartData")
    }

    @NSManaged public var priceString: String?
    @NSManaged public var productTitle: String?

}
