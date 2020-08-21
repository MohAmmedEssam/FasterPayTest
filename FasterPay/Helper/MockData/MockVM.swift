//
//  MockVM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/21/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation

class MockVM {
    struct Users:Codable{
        let users:[User]?
    }
    struct Payments:Codable{
        let payments:[PaymentHistory]?
    }
    
    
    func checkIfFirstTime(){
           let predicate = NSPredicate(format: "mail = %@", argumentArray: ["Moh@essam.com"])
           do{
               if let _ = try User.object(for: predicate){

               }else{
                addMockUsers()
                addMockPayments()
               }
           } catch(let error){
            print(error.localizedDescription)
            addMockUsers()
            addMockPayments()
           }
       }
       
       
       func addMockUsers(){
           CodableFuncs(fileName: "mockUsers").mockDecoder { (_ users:Users?) in
               guard let users = users?.users else{return}
               users.forEach({
                   let newUser = User.insertNewObject()
                   newUser.firstName = $0.firstName
                   newUser.lastName = $0.lastName
                   newUser.mail = $0.mail
                   newUser.password = $0.password
                   newUser.balance = $0.balance
                   newUser.currency = $0.currency
                   User.save()
               })
           }
       }
       func addMockPayments(){
           CodableFuncs(fileName: "mockPayments").mockDecoder { (_ payments:Payments?) in
               guard let payments = payments?.payments else{return}
               payments.forEach({
                   let newPayment = PaymentHistory.insertNewObject()

                   newPayment.mail = $0.mail
                   newPayment.processDate = $0.processDate
                   newPayment.productName = $0.productName
                   newPayment.company = $0.company
                   newPayment.amount = $0.amount
                   newPayment.currency = $0.currency

                   PaymentHistory.save()
               })
           }
       }
}
