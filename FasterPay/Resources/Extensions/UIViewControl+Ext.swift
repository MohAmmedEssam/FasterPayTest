//
//  UIViewControl+Ext.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func alert(title:String,message:String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    func alertAction(title:String,message:String,completion:@escaping ()->Void){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in  completion()}))
        present(ac, animated: true)
    }
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        
        child.view.centerXAnchor.constraint(equalTo:  self.view.centerXAnchor).isActive = true
        child.view.centerYAnchor.constraint(equalTo:  self.view.centerYAnchor).isActive = true

        child.view.widthAnchor.constraint(equalTo:  self.view.widthAnchor, multiplier: 1).isActive = true
        child.view.heightAnchor.constraint(equalTo:  self.view.heightAnchor, multiplier: 1).isActive = true
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        child.didMove(toParent: self)
    }
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIViewController:UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
