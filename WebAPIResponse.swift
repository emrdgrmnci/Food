//
//  WebAPIResponse.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 28.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation


public struct WebAPIResponse: Codable {
//    let statusCode: Int
//    let data: ServiceResponse
    
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case data = "data"
//    }
}

public struct AddressPostResponse: Codable {//AddressResponse
    let ResultObj: AddressPost?
    let ResultList: [AddressPost]?
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}

public struct RegisterServiceResponse: Codable {//UserRegisterResponse
    let ResultObj: User?
    let ResultList: [User]?
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}

public struct AddRemoveResponse: Codable {//Tüm AddRemove işlemleri
//    let ResultObj: NULL olacak
//    let ResultList: NULL olacak
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}

public struct SliderServiceResponse: Codable {//SliderServiceResponse
    let ResultObj: Slider?
    let ResultList: [Slider]?
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}

public struct FoodServiceResponse: Decodable {//FoodServiceResponse
    let ResultObj: Food?
    let ResultList: [Food]?
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}


