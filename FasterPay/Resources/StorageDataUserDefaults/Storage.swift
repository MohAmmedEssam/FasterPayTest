//
//  Storage.swift
//  Elmksataty
//
//  Created by Mahmoud Fares on 1/19/20.
//  Copyright © 2020 Mahmoud Fares. All rights reserved.
//

import Foundation
@propertyWrapper
struct propertyWrapperStorage<T: Codable> {
    
    struct Wrapper<T> : Codable where T : Codable {
        let wrapped : T
    }
    
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T{
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            do {
                let value = try JSONDecoder().decode(Wrapper<T>.self, from: data)
                return value.wrapped
            }catch{
                print("propertyWrapperStorageDecodeError: " + error.localizedDescription)
                return defaultValue
            }
        }
        
        set {
            do {
                let data = try JSONEncoder().encode(Wrapper(wrapped: newValue))
                UserDefaults.standard.set(data, forKey: key)
            }catch{
                print("propertyWrapperStorageEncodeError: " + error.localizedDescription)
            }
        }
    }
    
}
