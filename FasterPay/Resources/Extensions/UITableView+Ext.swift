//
//  UITableView+Ext.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/21/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func setEmptyMessage(_ msg:String? = nil) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = (msg ?? "No data exsist")
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}
