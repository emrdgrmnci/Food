//
//  User.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 28.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

struct User: Codable {
    var N: String! //Name
    var S: String! //Surname
    var E: String! //Email
    var P: String! //Phone
    var PS: String? //Pasword
    var RPS: String? //RePassword
    var I: Int? //id
}

/*
 public class RegisterDTO
 {
 public string N { get; set; } //Name
 public string S { get; set; } //Surname
 public string E { get; set; } //Email
 public string P { get; set; } //Phone
 public string PS { get; set; } //Pasword
 public string RPS { get; set; } //RePassword
 public string GC { get; set; } //Google Captcha
 public int? I { get; set; } //id
 }
*/


