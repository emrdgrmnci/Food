//
//  SliderNetwork.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 3.06.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import Moya

public enum SliderNetwork {
    case slider
//    case slider(Int, String, String, String, String, String, Date)
}

extension SliderNetwork: TargetType {
    public var baseURL: URL {
        return URL(string: "http://tezwebservice.pryazilim.com/api")!
    }
    
    public var path: String {
        switch self {
        case .slider: return "/SiteService/GetSliderList"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .slider: return .get
        }
    }
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .slider:
            return .requestPlain
//        case .slider(let id, let photoPath, let metin1, let metin2, let metin3, let url, let createdDate):
//            return .requestParameters(parameters: ["id" : id,
//                                                   "PhotoPath": photoPath,
//                                                   "Metin1": metin1,
//                                                   "Metin2": metin2,
//                                                   "Metin3": metin3,
//                                                   "Url": url,
//                                                   "CreatedDate": createdDate],
//                                      encoding: JSONEncoding.default)
        }
        
    }
    
    public var headers: [String : String]? {
        switch self {
        case .slider:
            return ["Content-Type": "application/json"]
        }
    }
}


/*
 Ayrıca sana photopath bilgisi gelen yerlerde domaini eklemeyi unutma.Aşağıdaki linklerin devamına photopath prop’u eklersin.
 Slider -> http://mehmetguner.pryazilim.com/UploadFile/Slider
 Ürün ->  http://mehmetguner.pryazilim.com/UploadFile/Product
 
 Slider Listesi
 [Route("api/SiteService/GetSliderList"), HttpGet]
 Result<DTO.Slider.SliderDTO> GetSliderList()
 
 
 public class SliderDTO
 {
 public int id { get; set; }
 public string PhotoPath { get; set; }
 public string Metin1 { get; set; }
 public string Metin2 { get; set; }
 public string Metin3 { get; set; }
 public string Url { get; set; }
 public DateTime CreatedDate { get; set; }
 }
 */
