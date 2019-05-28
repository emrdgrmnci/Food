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

public struct ServiceResponse: Codable {//AddressResponse
    let ResultObj: AddressPost?
    let ResultList: [AddressPost]?
    let Message: String?
    let Success: Bool!
    let Statue: Int?
}


