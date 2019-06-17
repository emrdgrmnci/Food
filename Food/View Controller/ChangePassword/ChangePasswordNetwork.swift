//
//  ChangePasswordNetwork.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 17.06.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import Moya

enum ChangePasswordNetwork {
    case changePassword(String, String, String)
}

let changePasswordUserIDDefault = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0

extension ChangePasswordNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
            
        case .changePassword: return "/UserService/ProfilePasswordChange"
   
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .changePassword: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
            
        case .changePassword(let currentPassword, let newPassword, let reNewPassword):
            return .requestParameters(parameters: ["PP" : currentPassword,
                                                   "NP": newPassword,
                                                   "RNP": reNewPassword,
                                                   "UI" : changePasswordUserIDDefault],
                                      encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            //            "Authorization": "\(UserDefaults.standard.object(forKey: "token")!)"
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

