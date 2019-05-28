//
//  User.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 28.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

struct User: Decodable {
    var name: String
    var surname: String
    var email: String
    var phone: String
    var id: Int
}


