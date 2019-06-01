//
//  Validations.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

extension String {
    
    //MARK: Phone number validation
//    var isPhoneNumber: Bool {
//        
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{10}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: self)
//        return result
//        
//    }
    
    //MARK: E-mail validation
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValid: Bool {
        guard self.count > 2, self.count < 18 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "")
        return predicateTest.evaluate(with: self)
    }
    
}
