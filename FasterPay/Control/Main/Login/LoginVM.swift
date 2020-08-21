//
//  LoginVM.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import UIKit

class LoginVM {
    
    private var mail:String?
    private var password:String?
    
    private var rootVC:UIViewController?
    private var errors:String?


    init(mail:String?,password:String?) {
        self.mail = mail
        self.password = password
        self.rootVC = UIApplication.shared.keyWindow?.rootViewController
        self.errors = ""
    }
    deinit {
        self.mail = nil
        self.password = nil
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
        return valid
    }
    
    
    //try Action
    func tryLogin(callBack: @escaping (_ user:User)->Void){
        guard isValid() else{
            rootVC?.alert(title: "Error", message: errors!)
            return
        }
        let predicate = NSPredicate(format: "mail = %@", argumentArray: [self.mail!])
        do{
            if let currentUser = try User.object(for: predicate){
                if currentUser.password == self.password{
                    AppData.user = currentUser
                    AppData.autoLoginKey = true
                    callBack(currentUser)
                }else{
                    print("Wrong Password")
                    rootVC?.alert(title: "Error", message: "Wrong Password")
                }
            }else{
                print("Wrong Mail")
                rootVC?.alert(title: "Error", message: "Wrong Mail")
            }
        } catch(let error){
            print(error.localizedDescription)
        }
        
    }
    
}
