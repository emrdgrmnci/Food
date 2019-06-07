//
//  GetAddressNetwork.swift
//  Alamofire
//
//  Created by Ali Emre Değirmenci on 7.06.2019.
//

import Foundation
import Moya

enum GetInfoNetwork {
    case getInfo
}
let defaultUserID = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0
extension GetInfoNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
            
        case .getInfo: return "/UserService/GetUserDetail/\(defaultUserID)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getInfo: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getInfo:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getInfo:
            return [
                "Content-Type": "application/json"]
            //            "Authorization": "\(UserDefaults.standard.object(forKey: "token")!)"
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

