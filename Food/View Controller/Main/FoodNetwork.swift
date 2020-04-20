////
////  FoodNetwork.swift
////  Food
////
////  Created by Ali Emre Değirmenci on 3.06.2019.
////  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
////
//
//import Foundation
//import Moya
//import SwiftyJSON
//
//var fromSharedFood = SingletonCart.sharedFood.food
//
//var userDefaultID = UserDefaults.standard.object(forKey: "userID") as? Int ?? 0
//
//public enum FoodNetwork {
//    case food
//    case createOrder(Int, String, String)
//}
//
//extension FoodNetwork: TargetType {
//    public var baseURL: URL {
//        return URL(string: "http://tezwebservice.pryazilim.com/api")!
//    }
//    
//    public var path: String {
//        switch self {
//        case .food: return "/ProductService/GetAllProductList"
//        case .createOrder: return "/OrderService/CreateOrder"
//        }
//    }
//    
//    public var method: Moya.Method {
//        switch self {
//        case .food: return .get
//        case .createOrder: return .post
//        }
//    }
//    public var sampleData: Data {
//        return Data()
//    }
//    
//    public var task: Task {
//        switch self {
//        case .food:
//            return .requestPlain
//        case .createOrder(let addressID,let productExplanation, let productListJSON):
//            
//            return .requestParameters(parameters: ["addressID" : addressID,
//                                                   "userID": userDefaultID,
//                                                   "productList": productListJSON,
//                                                   "productExplanation": productExplanation],
//                                      encoding: JSONEncoding.default)
//        }
//    }
//    
//    public var headers: [String : String]? {
//        return [
//            "Content-Type": "application/json",
//            //            "Authorization": "\(UserDefaults.standard.object(forKey: "token")!)"
//        ]
//    }
//}
//
//
