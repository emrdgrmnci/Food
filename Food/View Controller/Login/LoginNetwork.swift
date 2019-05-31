//
//  LoginNetwork.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 30.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import Moya

let loginDefaults = UserDefaults.standard

public enum LoginNetwork {
    case login(String,String)
}

extension LoginNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
        case .login: return "/UserService/Login"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login: return .post
        }
    }
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["E": email,
                                                   "PS": password],
                                      encoding: JSONEncoding.default)
        }
        
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
}
