//
//  PaymentVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    @IBOutlet weak var companyNameLa: UILabel!
    @IBOutlet weak var productLa: UILabel!
    @IBOutlet weak var totalAmountLa: UILabel!
    @IBOutlet weak var subtotalLa: UILabel!
    @IBOutlet weak var feeLa: UILabel!
    @IBOutlet weak var balanceLa: UILabel!
    @IBOutlet weak var payButtOutlet: UIButton!

    
    var model:Payment?
    private var viewModel:PaymentVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataFromModel()
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Payment"
        self.view.layoutIfNeeded()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func addDataFromModel(){
        guard let model = model else{return}
        companyNameLa.text = model.companyName
        productLa.text = model.productName
        totalAmountLa.text = "\(model.currency ?? "USD") \(model.total ?? 0.0)"
        subtotalLa.text = "\(model.currency ?? "USD") \(model.subTotal ?? 0.0)"
        feeLa.text = "\(model.currency ?? "USD") \(model.fee ?? 0.0)"
        balanceLa.text = "\(AppData.user?.currency ?? "USD") \(AppData.user?.balance ?? "0.0")"
        payButtOutlet.setTitle("Pay \(model.currency ?? "USD") \(model.total ?? 0.0)", for: .normal)
    }
    private func initViewModel(){
        viewModel = PaymentVM(model)
        payButtOutlet.setTitle(viewModel?.getPayButtName(), for: .normal)
    }
    @IBAction func payAction(_ sender: Any) {
        viewModel?.checkBalance{[weak self](success,message) in
            if success{
                let vc = SuccessViewVC()
                vc.transactionCode = message
                self?.add(vc)
            }else{
                self?.alert(title:"Error processing your request",message:message)
            }
        }
    }

}
