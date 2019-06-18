//
//  SingletonCart.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 23.04.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import UIKit

class SingletonCart {
    static let sharedFood = SingletonCart()
    var food: [Food] = []
    
    private init() {}
    
    static func dispose() -> Void
    {
        SingletonCart.sharedFood.food = [Food]()
    }
}





