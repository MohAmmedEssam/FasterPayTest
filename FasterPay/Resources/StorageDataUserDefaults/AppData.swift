//
//  AppData.swift
//  Elmksataty
//
//  Created by Mahmoud Fares on 1/19/20.
//  Copyright © 2020 Mahmoud Fares. All rights reserved.
//

import Foundation
struct AppData {
    
    // Declare a EnableAutoLogin object
    @propertyWrapperStorage(key: "autoLoginKey",defaultValue: false)
    static var autoLoginKey: Bool
    
    
    @propertyWrapperStorage(key: "user",defaultValue: nil)
    static var user: User?
}


