//
//  WalletVM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation

class WalletVM{
    func getAllTransactions(completion: @escaping (_ dictionary:[String:[PaymentHistory]])->Void){
        let predicate = NSPredicate(format: "mail = %@", argumentArray: [AppData.user?.mail ?? ""])
        do{
            let currentUserTransactions = try PaymentHistory.objects(for: predicate)
            currentUserTransactions.forEach({$0.processDate = $0.processDate?.toDate})
            let dictionary = Dictionary(grouping: currentUserTransactions, by:  { $0.processDate! })
            completion(dictionary)
        } catch(let error){
            print(error.localizedDescription)
        }
    }
    
}
