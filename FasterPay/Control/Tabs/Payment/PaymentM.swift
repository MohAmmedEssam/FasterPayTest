//
//  PaymentM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation

struct Payment:Codable {
    let companyName: String?
    let currency: String?
    let productName: String?
    
    let total: Double?
    let subTotal: Double?
    let fee: Double?
}
