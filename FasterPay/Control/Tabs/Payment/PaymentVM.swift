//
//  PaymentVM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation

class PaymentVM{
    var model:Payment?
    
    init(_ model:Payment?){
        self.model = model
    }
    deinit {
        self.model = nil
    }
    func getPayButtName()->String{
        guard let paymentCurrencyKind = Currencies(rawValue: model?.currency ?? "USD")else{return ""}
        let equivalentPayment = ((model?.total ?? 0.0) * paymentCurrencyKind.factor)
        return "Pay USD \(equivalentPayment)"
    }
    func checkBalance(completion:@escaping (_ success:Bool,_ message:String)->Void){
        if  let userBalance = (AppData.user?.balance ?? "0.0").Double{
            guard let userCurrencyKind = Currencies(rawValue: AppData.user?.currency ?? "USD"),
                let paymentCurrencyKind = Currencies(rawValue: model?.currency ?? "USD")else{
                    completion(false,"Not exist currency")
                    return
            }
            let equivalentUserBalance = (userBalance * userCurrencyKind.factor)
            let equivalentPayment = ((model?.total ?? 0.0) * paymentCurrencyKind.factor)
            
            if  equivalentUserBalance >= equivalentPayment{
                let date = "\(Int(Date().timeIntervalSince1970)*1000)"
                
                proceedPayment(processNum: date)
                updateUserBalance(userBalance:equivalentUserBalance, transaction:equivalentPayment)
                
                completion(true,date)
            }else{
                completion(false,"No enough balance")
            }
        }else{
            completion(false,"No enough balance")
        }
    }
    
    private func proceedPayment(processNum:String){
        let newPayment = PaymentHistory.insertNewObject()

        newPayment.mail = AppData.user?.mail
        newPayment.processDate = processNum
        newPayment.productName = model?.productName
        newPayment.company = model?.companyName
        newPayment.amount = "\(model?.total ?? 0)"
        newPayment.currency = model?.currency

        PaymentHistory.save()
    }
    private func updateUserBalance(userBalance:Double,transaction:Double){
        let predicate = NSPredicate(format: "mail = %@", argumentArray: [AppData.user?.mail ?? ""])
        do{
            if let currentUser = try User.object(for: predicate){
                let newBalance = userBalance - transaction
                currentUser.balance = "\(newBalance)"
                AppData.user = currentUser
                
                User.save()
            }
        } catch(let error){
            print(error.localizedDescription)
        }
    }
}


enum Currencies:String{
    case USD = "USD"
    case EUR = "EUR"
    case GBP = "GBP"
    
    var factor:Double{
        switch self {
        case .USD:
            return 1
        case .EUR:
            return 1.18
        case .GBP:
            return 1.31
            
        }
    }
}
