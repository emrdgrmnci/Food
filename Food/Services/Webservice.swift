//
//  Webservice.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 13.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

class Webservice {
    
    func getFoods(url: URL, completion: @escaping ([Food]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                print(data)
            }
        }
        
    }
    
}
