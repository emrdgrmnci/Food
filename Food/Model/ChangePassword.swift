//
//  ChangePassword.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 17.06.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

struct ChangePassword: Codable {
    var PP: String! //Şu an ki şifre
    var NP: String! //Yeni şifre
    var RNP: String! //Yeni şifre tekrar
    var UI: String! //UserID
}
