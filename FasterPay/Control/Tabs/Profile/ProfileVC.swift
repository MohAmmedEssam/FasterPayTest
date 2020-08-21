//
//  ProfileVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var nameLa: UILabel!
    @IBOutlet weak var mailLa: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let optionsArray = ["LogOut"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addUserData()
    }
    private func addUserData(){
        guard let user = AppData.user else{return}
        self.nameLa.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        self.mailLa.text = user.mail
    }

}

//MARK:- UITableViewDelegate
extension ProfileVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionsArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = optionsArray[indexPath.section]
        cell.imageView?.image = UIImage(named: optionsArray[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch optionsArray[indexPath.section] {
        case "LogOut":
            AppData.autoLoginKey = false
            AppData.user = nil
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
    }
}
