//
//  GetAddressNetwork.swift
//  Alamofire
//
//  Created by Ali Emre Değirmenci on 7.06.2019.
//

import Foundation
import Moya

enum GetAddressNetwork {
    case getAddressList
}
let userIDDefault = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0
extension GetAddressNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
            
        case .getAddressList: return "/UserService/GetUserAddressList/\(userIDDefault)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAddressList: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
            
        case .getAddressList:
            
            return .requestPlain
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

