//
//  RegisterVM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import UIKit

class RegisterVM {
    
    private var mail:String?
    private var password:String?
    private var firstName: String?
    private var lastName: String?
    private var isSwitchOn: Bool?
    
    private var rootVC:UIViewController?
    private var errors:String?
    init(mail:String?,password:String?,firstName:String?,lastName:String?,isSwitchOn:Bool?) {
        self.mail = mail
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.isSwitchOn = isSwitchOn
        
        self.rootVC = UIApplication.shared.keyWindow?.rootViewController
        self.errors = ""
    }
    deinit {
        self.mail = nil
        self.password = nil
        self.firstName = nil
        self.lastName = nil
        self.isSwitchOn = nil
        
        self.rootVC = nil
        self.errors = nil
    }
    
    //CheckValidation
    private func isValid()->Bool{
        var valid = true
        
        if let mail = self.mail,mail.isValidEmail{
            
        }else{
            print("Invalid Mail")
            errors! += "\nInvalid Mail"
            valid = false
        }
        
        if let password = self.password,password.isValidPassword{
            
        }else{
            print("Invalid Password")
            errors! += "\nInvalid Password"
            valid = false
        }
        
        if let firstName = self.firstName,firstName.isValidName{
            
        }else{
            print("Invalid First Name")
            errors! += "\nInvalid First Name"
            valid = false
        }
        
        if let lastName = self.lastName,lastName.isValidName{
            
        }else{
            print("Invalid last Name")
            errors! += "\nInvalid Last Name"
            valid = false
        }
        
        if let isSwitchOn = self.isSwitchOn,isSwitchOn{
            
        }else{
            print("Invalid Switch State")
            errors! += "\nInvalid Switch State"
            valid = false
        }
        
        return valid
    }
    private func isMailExist()->Bool{
        var isExist = true

        let predicate = NSPredicate(format: "mail = %@", argumentArray: [self.mail!])
        do{
            isExist = (try User.object(for: predicate) != nil)
        } catch(let error){
            print(error.localizedDescription)
            isExist = false
        }
        
        return isExist
    }
    
    //try Action
    func tryRegister(callBack: @escaping (_ user:User)->Void){
        guard isValid() else{
            rootVC?.alert(title: "Error", message: errors!)
            return
        }
        guard !isMailExist()else{
            rootVC?.alert(title: "Error", message: "Mail already exist")
            return
        }
        
        let randomBalance = Int.random(in: 300...2000)
        let newUser = User.insertNewObject()
        
        newUser.firstName = self.firstName
        newUser.lastName = self.lastName
        newUser.mail = self.mail
        newUser.password = self.password
        newUser.balance = "\(randomBalance)"
        newUser.currency = "USD"

        User.save()

        AppData.user = newUser
        AppData.autoLoginKey = true
        
        callBack(newUser)
    }
    
}
