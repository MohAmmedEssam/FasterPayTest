//
//  DesignSystem.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/18/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Colors
class DesignSystem{
    
    enum sysColor: String {
        case dark_purple
        case white_purple
        case appYellow
        case selectedTab
        
        var name:String{
            switch self {
            case .dark_purple:
                return "dark_purple"
            case .white_purple:
                return "white_purple"
            case .appYellow:
                return "appYellow"
            case .selectedTab:
                return "selectedTab"
            }
        }
    }
    static func appColor(_ color:sysColor)->UIColor{
        return UIColor(named: color.name) ?? UIColor.black
    }
}

//MARK:- Fonts
extension DesignSystem{
    enum sysFont {
        case veryLarge
        case large
        case medium
        case small
        case normal
        
        var name:UIFont{
            switch self {
            case .veryLarge:
                return .systemFont(ofSize: 20,weight: .bold)
            case .large:
                return .systemFont(ofSize: 17,weight: .bold)
            case .medium:
                return .systemFont(ofSize: 17,weight: .medium)
            case .small:
                return .systemFont(ofSize: 12,weight: .regular)
            case .normal:
                return .systemFont(ofSize: 17,weight: .regular)
            }
        }
    }

    static func appFont(_ font:sysFont)->UIFont{
        return font.name
    }
}
