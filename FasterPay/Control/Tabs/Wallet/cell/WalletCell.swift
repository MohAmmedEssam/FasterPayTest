//
//  WalletCell.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class WalletCell: UITableViewCell {
    @IBOutlet weak var companyNameLa: UILabel!
    @IBOutlet weak var productNameLa: UILabel!
    @IBOutlet weak var priceLa: UILabel!

    var transaction:PaymentHistory?{
        didSet{
            cellManagement()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func cellManagement(){
        guard let transaction = transaction else{return}
        companyNameLa.text = transaction.company
        productNameLa.text = transaction.productName
        priceLa.text = "\(transaction.currency ?? "USD") \(transaction.amount ?? "0")"
    }
}
