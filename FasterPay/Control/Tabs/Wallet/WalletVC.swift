//
//  WalletVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class WalletVC: UIViewController {
    
    @IBOutlet weak var balanceLa: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl = UIRefreshControl()
    private var keys = [String]()
    private var dictionary:[String:[PaymentHistory]] = [:]{
        didSet{
            keys = Array(dictionary.keys)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WalletCell", bundle: nil), forCellReuseIdentifier: "WalletCell")
        addRefreshControl()
        
        addUserData()
        getTransactions()
    }
    private func addUserData(){
        guard let user = AppData.user else{return}
        self.balanceLa.text = "\(user.currency ?? "USD") \(user.balance ?? "")"
    }
    private func getTransactions(){
        WalletVM().getAllTransactions{[weak self] transactions in
            self?.dictionary = transactions
            self?.tableView.reloadData()
        }
    }
    private func addRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        addUserData()
        getTransactions()
        refreshControl.endRefreshing()
    }
}

//MARK:- UITableViewDelegate
extension WalletVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return keys.count > 1 ? 1:0
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .white
            headerView.textLabel?.textColor =  .lightGray
            headerView.textLabel?.textAlignment =  .center
            headerView.textLabel?.font =  DesignSystem.appFont(.small)
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        keys.isEmpty ? tableView.setEmptyMessage():tableView.removeEmptyMessage()
        return keys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary[keys[section]]!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletCell
        let values = dictionary[keys[indexPath.section]]!
        cell.transaction = values[indexPath.row]
        return cell
    }
    
}
