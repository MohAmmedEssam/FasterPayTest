//
//  PaymentModel.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import CoreData
@objc(PaymentHistory)
class PaymentHistory: NSManagedObject,Codable,Fetchable {
  
    // MARK: - NSManged Properties
    @NSManaged var mail: String?
    @NSManaged var processDate: String?
    @NSManaged var productName: String?
    @NSManaged var company: String?
    @NSManaged var amount: String?
    @NSManaged var currency: String?
    
    // MARK: - AttributeName for sorting attribute keys
    enum AttributeName:String{
        case processDate
    }
    


    // MARK: - Codable
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case mail, processDate, productName, company, amount, currency
    }

    required convenience init(from decoder: Decoder) throws {
        // Create NSEntityDescription with NSManagedObjectContext
        self.init(entity: PaymentHistory.entityDescription, insertInto: nil)
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mail = try values.decode(String.self, forKey: .mail)
            processDate = try values.decode(String.self, forKey: .processDate)
            productName = try values.decode(String.self, forKey: .productName)
            company = try values.decode(String.self, forKey: .company)
            amount = try values.decode(String.self, forKey: .amount)
            currency = try values.decode(String.self, forKey: .currency)

        }catch(let error){
            print("decoder error",error.localizedDescription)
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(mail, forKey: .mail)
            try container.encode(processDate, forKey: .processDate)
            try container.encode(productName, forKey: .productName)
            try container.encode(company, forKey: .company)
            try container.encode(amount, forKey: .amount)
            try container.encode(currency, forKey: .currency)
        }catch(let error){
            print("encoder error",error.localizedDescription)
        }
    }

}
