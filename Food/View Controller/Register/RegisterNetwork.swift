//
//  RegisterNetwork.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 27.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import Moya

let registerDefaults = UserDefaults.standard

public enum RegisterNetwork {
    case register(String,String,String,String,String,String)
}

extension RegisterNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
        case .register: return "/UserService/Register"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .register: return .post
        }
    }
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .register(let name, let surname, let email, let phone, let password, let rePassword):
            return .requestParameters(parameters: ["N" : name,
                                                   "S": surname,
                                                   "E": email,
                                                   "P": phone,
                                                   "PS": password,
                                                   "RPS": rePassword],
                                      encoding: JSONEncoding.default)
        }
        
    }
    
    public var headers: [String : String]? {
        switch self {
        case .register:
            return ["Content-Type": "application/json"]
        }
    }
}
//api/UserService/Register

/*public class RegisterDTO
 {
 public string N { get; set; } //Name
 public string S { get; set; } //Surname
 public string E { get; set; } //Email
 public string P { get; set; } //Phone
 public string PS { get; set; } //Password
 public string RPS { get; set; } //RePassword
 public string GC { get; set; } //Google Captcha
 public int? I { get; set; } //id
 }
 */
