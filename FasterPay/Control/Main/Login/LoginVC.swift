//
//  LoginVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/18/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
         
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAutoLogin()
    }
    private func checkAutoLogin(){
        if AppData.autoLoginKey{
            LoginNow()
        }
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        let viewModel = LoginVM(mail: emailTxt.text, password:passwordTxt.text)
        viewModel.tryLogin(){[weak self] (user) in
            self?.LoginNow()
        }
    }
    private func LoginNow(){
        let storyBoard = UIStoryboard(name: "Tabs", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    @IBAction func SignupAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

