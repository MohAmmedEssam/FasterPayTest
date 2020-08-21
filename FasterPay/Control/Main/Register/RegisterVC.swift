//
//  RegisterVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var agreeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        let viewModel = RegisterVM(mail: emailTxt.text,
                                   password:passwordTxt.text,
                                   firstName:firstNameTxt.text,
                                   lastName:lastNameTxt.text,
                                   isSwitchOn:agreeSwitch.isOn)
        viewModel.tryRegister(){[weak self] (user) in
            self?.registerNow()
        }
    }
    private func registerNow(){        
        let storyBoard = UIStoryboard(name: "Tabs", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

