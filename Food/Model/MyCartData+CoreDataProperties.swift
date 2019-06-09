//
//  MyCartData+CoreDataProperties.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 8.06.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//
//

import Foundation
import CoreData


extension MyCartData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyCartData> {
        return NSFetchRequest<MyCartData>(entityName: "MyCartData")
    }

    @NSManaged public var fromDetailFoodNames: String?
    @NSManaged public var fromDetailFoodPrices: String?

}
