//
//  UserModel.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import CoreData
@objc(User)
class User: NSManagedObject,Codable,Fetchable {
  
    // MARK: - NSManged Properties
    @NSManaged var mail: String?
    @NSManaged var password: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var balance: String?
    @NSManaged var currency: String?
    
    // MARK: - AttributeName for sorting attribute keys 
    enum AttributeName:String{
        case name,birthDate
    }
    


    // MARK: - Codable
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case mail, password, firstName, lastName, balance, currency
    }

    required convenience init(from decoder: Decoder) throws {
        // Create NSEntityDescription with NSManagedObjectContext
        self.init(entity: User.entityDescription, insertInto: nil)
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mail = try values.decode(String.self, forKey: .mail)
            password = try values.decode(String.self, forKey: .password)
            firstName = try values.decode(String.self, forKey: .firstName)
            lastName = try values.decode(String.self, forKey: .lastName)
            balance = try values.decode(String.self, forKey: .balance)
            currency = try values.decode(String.self, forKey: .currency)

        }catch(let error){
            print("decoder error",error.localizedDescription)
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(mail, forKey: .mail)
            try container.encode(password, forKey: .password)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(balance, forKey: .balance)
            try container.encode(currency, forKey: .currency)
        }catch(let error){
            print("encoder error",error.localizedDescription)
        }
    }

}
