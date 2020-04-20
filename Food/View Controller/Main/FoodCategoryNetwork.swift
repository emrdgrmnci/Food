////
////  FoodNetwork.swift
////  Food
////
////  Created by Ali Emre Değirmenci on 6.06.2019.
////  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
////
//
//import Foundation
//
//
//public enum FoodCategoryNetwork {
//    //    case food(Int, Int, String, String, Int, Int, String, String, String, Bool, String, String, Int, String, [String])
//    case foodCategory
//}
//
//extension FoodCategoryNetwork: TargetType {
//    public var baseURL: URL {
//        return URL(string: "http://tezwebservice.pryazilim.com/api")!
//    }
//    
//    public var path: String {
//        switch self {
//        case .foodCategory: return "/ProductService/GetSubCategoryAllProductList"
//        }
//    }
//    
//    public var method: Moya.Method {
//        switch self {
//        case .foodCategory: return .get
//        }
//    }
//    public var sampleData: Data {
//        return Data()
//    }
//    
//    public var task: Task {
//        switch self {
//        case .foodCategory:
//            return .requestPlain
//            //        case .food(let id, let subCategoryID, let subCategoryTitle, let categoryTitle, let price, let oldPrice, let priceString, let oldPriceString, let productTitle, let isIndexView, let photoPath, let foodDescription, let stock, let details, let detailsList):
//            //            return .requestParameters(parameters: ["id" : id,
//            //                                                   "SubCategoryId": subCategoryID,
//            //                                                   "SubCategoryTitle": subCategoryTitle,
//            //                                                   "CategoryTitle": categoryTitle,
//            //                                                   "Price": price,
//            //                                                   "OldPrice": oldPrice,
//            //                                                   "PriceString": priceString,
//            //                                                   "OldPriceString": oldPriceString,
//            //                                                   "ProductTitle": productTitle,
//            //                                                   "IsIndexView": isIndexView,
//            //                                                   "PhotoPath": photoPath,
//            //                                                   "Description": foodDescription,
//            //                                                   "Stock": stock,
//            //                                                   "Details": details,
//            //                                                   "DetailsList": [detailsList]],
//            //                                      encoding: JSONEncoding.default)
//        }
//        
//    }
//    
//    public var headers: [String : String]? {
//        switch self {
//        case .foodCategory:
//            return ["Content-Type": "application/json"]
//        }
//    }
//}
//
//
///*
// Ayrıca sana photopath bilgisi gelen yerlerde domaini eklemeyi unutma.Aşağıdaki linklerin devamına photopath prop’u eklersin.
// Slider -> http://mehmetguner.pryazilim.com/UploadFile/Slider
// Ürün ->  http://mehmetguner.pryazilim.com/UploadFile/Product
// 
// Slider Listesi
// [Route("api/SiteService/GetSliderList"), HttpGet]
// Result<DTO.Slider.SliderDTO> GetSliderList()
// 
// 
// public class SliderDTO
// {
// public int id { get; set; }
// public string PhotoPath { get; set; }
// public string Metin1 { get; set; }
// public string Metin2 { get; set; }
// public string Metin3 { get; set; }
// public string Url { get; set; }
// public DateTime CreatedDate { get; set; }
// }
// */
//
