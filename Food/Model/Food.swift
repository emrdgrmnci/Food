//
//  FoodCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 5.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation


struct Food: Codable {
    let id, SubCategoryId: Int
    let SubCategoryTitle, CategoryTitle: String
    let Price, OldPrice: Decimal
    let PriceString, OldPriceString, ProductTitle: String
    let IsIndexView: Bool
    let PhotoPath: String
    let Description: String
    let Stock: Int
    let Details: String
    let DetailsList: [String]
}








