//
//  GetAddressNetwork.swift
//  Alamofire
//
//  Created by Ali Emre Değirmenci on 7.06.2019.
//

import Foundation
import Moya

enum GetPostAddressNetwork {
    case getAddressList
    case updateAddressList(Int, String, String, String)
    case deleteAddressList(Int)
    case createAddressList(String, String, String)
}
let userIDDefault = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0
extension GetPostAddressNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
            
        case .getAddressList: return "/UserService/GetUserAddressList/\(userIDDefault)"
        case .updateAddressList: return "/UserService/UpdateAddress"
        case .deleteAddressList: return "/UserService/DeleteAddress"
        case .createAddressList: return "/UserService/AddAddress"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAddressList: return .get
        case .updateAddressList: return .post
        case .deleteAddressList: return .post
        case .createAddressList: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
            
        case .getAddressList:
            
            return .requestPlain
            
        case .updateAddressList(let postAddressID, let addressTitle, let address, let addressExplanation):
            return .requestParameters(parameters: ["I" : postAddressID,
                                                   "T" : addressTitle,
                                                   "A" : address,
                                                   "AR": addressExplanation,
                                                   "UI": userIDDefault],
                                      encoding: JSONEncoding.default)
        case .deleteAddressList(let addressID):
            return .requestParameters(parameters: ["I" : addressID,
                                                   "UI": userIDDefault],
                                      encoding: JSONEncoding.default)
            
        case .createAddressList(let addressTitle, let address, let addressExplanation):
            return .requestParameters(parameters: ["T" : addressTitle,
                                                   "A" : address,
                                                   "AR": addressExplanation,
                                                   "UI": userIDDefault],
                                      encoding: JSONEncoding.default)
        }
        }
    
    public var headers: [String : String]? {
        switch self {
        case .updateAddressList:
            return ["Content-Type": "application/json"]
        case .getAddressList:
            return ["Content-Type": "application/json"]
        case .deleteAddressList:
            return ["Content-Type": "application/json"]
        case .createAddressList:
            return ["Content-Type": "application/json"]
        }
    }
    
//    public var validationType: ValidationType {
//        return .successCodes
//    }

}
