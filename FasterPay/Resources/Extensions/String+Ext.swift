//
//  String+Ext.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
extension String {
    var isValidEmail:Bool {
        let RegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predict = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return predict.evaluate(with: self)
    }
    
    var isValidName:Bool {
        let RegEx = "[a-z A-Z ]+"
        let predict = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return predict.evaluate(with: self)
    }
    var isValidPassword:Bool {
//        Explanation:
//        -------------
//        ^                         Start anchor
//        (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
//        (?=.*[!@#$&*])            Ensure string has one special case letter.
//        (?=.*[0-9].*[0-9])        Ensure string has two digits.
//        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
//        .{8}                      Ensure string is of length 8.
//        $                         End anchor.
        let RegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,20}$"
        let predict = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return predict.evaluate(with: self)
    }
    
    var Double:Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    var toDate:String{
        guard let timeDouble = self.Double else{return self}
        let messageDate = Date.init(timeIntervalSince1970: timeDouble/1000)
        let dataformatter = DateFormatter.init()
        dataformatter.dateFormat = "dd.MM.yyyy"

        let date = dataformatter.string(from: messageDate )
        return date
    }

}


