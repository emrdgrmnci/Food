//
//  ContentDetailNetwork.swift
//  Codiagno
//
//  Created by Mahmut Acar on 28.03.2019.
//  Copyright © 2019 Mahmut Acar. All rights reserved.
//

import Foundation
import Moya

enum GetAddressNetwork {
    case getAddressList
    case postLogin(String, String)
}

extension GetAddressNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
        case .getAddressList: return "/UserService/GetUserAddressList/1"
        case .postLogin: return "/UserService/Login"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAddressList: return .get
        case .postLogin: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
            
        case .getAddressList:
            
            return .requestPlain
            
        case .postLogin(let email , let password):
            
            return .requestParameters(
                parameters: [
                    "E": email,
                    "PS": password
                ], encoding: JSONEncoding.default)
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
