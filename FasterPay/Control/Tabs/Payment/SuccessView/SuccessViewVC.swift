//
//  SuccessViewViewController.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class SuccessViewVC: UIViewController {
    @IBOutlet weak var transactionCodeLa: UILabel!
    
    var transactionCode = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.transactionCodeLa.text = transactionCode
    }
    
    @IBAction func okAction(_ sender: Any) {
        self.parent?.navigationController?.popViewController(animated: true)
    }

}
