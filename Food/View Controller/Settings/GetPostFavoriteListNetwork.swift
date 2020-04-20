////
////  GetAddressNetwork.swift
////  Alamofire
////
////  Created by Ali Emre Değirmenci on 7.06.2019.
////
//
//import Foundation
//import Moya
//
//enum GetPostFavoriteListNetwork {
//    case getFavoriteList
//    case postCreateFavorite(Int)
//    case postDeleteFavorite(Int)
//    case isFavorite(Int)
//}
//
//let getFavoriteUserIDDefault = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0
//
//extension GetPostFavoriteListNetwork: TargetType {
//    
//    public var baseURL: URL {
//        return URL(string: "http://tezwebservice.pryazilim.com/api")!
//    }
//    
//    public var path: String {
//        switch self {
//            
//        case .getFavoriteList: return "/ProductService/GetFavoriteProductList/\(getFavoriteUserIDDefault)"
//        case .postCreateFavorite: return "/ProductService/AddFavorite"
//        case .postDeleteFavorite: return "/ProductService/DeleteFavorite"
//        case .isFavorite: return "/ProductService/IsFavorite"
//        }
//    }
//    
//    public var method: Moya.Method {
//        switch self {
//        case .getFavoriteList: return .get
//        case .postCreateFavorite: return .post
//        case .postDeleteFavorite: return .post
//        case .isFavorite: return .post
//        }
//    }
//    
//    public var sampleData: Data {
//        return Data()
//    }
//    
//    public var task: Task {
//        switch self {
//            
//        case .getFavoriteList:
//            
//            return .requestPlain
//        
//            
//        case .postCreateFavorite(let id):
//            return .requestParameters(parameters: ["I" : id,
//                                                   "UI": getFavoriteUserIDDefault],
//                                      encoding: JSONEncoding.default)
//        case .postDeleteFavorite(let id):
//            return .requestParameters(parameters: ["I" : id,
//                                                   "UI" : getFavoriteUserIDDefault], encoding: JSONEncoding.default)
//        case .isFavorite(let id):
//            return .requestParameters(parameters: ["I" : id,
//                                                   "UI": getFavoriteUserIDDefault],
//                                      encoding: JSONEncoding.default)
//        }
//        }
//    
//    public var headers: [String : String]? {
//        return [
//            "Content-Type": "application/json",
//            //            "Authorization": "\(UserDefaults.standard.object(forKey: "token")!)"
//        ]
//    }
//    
//    public var validationType: ValidationType {
//        return .successCodes
//    }
//}
//
