//
//  MainNavigation.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit

class MainNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        handleNavigationControl()
    }
    
    private func handleNavigationControl(){
        self.navigationBar.barTintColor = DesignSystem.appColor(.dark_purple)
        self.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0,vertical: 0.0),for: .default)
        self.navigationBar.isHidden=true
    }

}
