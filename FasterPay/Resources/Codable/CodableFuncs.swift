//
//  CodableFuncs.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/19/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import Foundation

class CodableFuncs{
    private var data:Data?
    private var dictionary:[String: Any]?
    private var model:Codable?
    private var fileName:String?

    init(data:Data? = nil,
         dictionary:[String: Any]? = nil,
         fileName:String? = nil) {
        self.data = data
        self.dictionary = dictionary
        self.fileName = fileName
    }
    deinit {
        self.data = nil
        self.dictionary = nil
        self.fileName = nil
    }
    
    
    func mockDecoder<T: Codable> (completion:@escaping (T?) -> Void) {
        guard let fileName = fileName else{
            completion(nil)
            return
        }
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let decoder = JSONDecoder()
                    let DataResponsed = try decoder.decode(T.self, from: data)
                    completion(DataResponsed)
                } catch {
                    print("print decoding error",error)
                    completion(nil)
                }
            } catch {
                // handle error
                print("File not Found error",error)
                completion(nil)
            }
        }
    }
    //MARK:- Decode
    func Decode<T: Codable> (completion:@escaping (T?) -> Void) {
        if let dictionary = dictionary{
            self.data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }
        guard let data = data else{
            completion(nil)
            return
        }
        do {
            let decoder = JSONDecoder()
            let DataResponsed = try decoder.decode(T.self, from: data)
            completion(DataResponsed)
        } catch {
            print("print decoding error",error)
            completion(nil)
        }
    }
    //MARK:- Encode
     func Encode<T: Codable> (_ model:T, completion:@escaping ([String: Any]?) -> Void) {
        let json = try! JSONEncoder().encode(model)
        let params = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String: Any]
        completion(params)
    }
}
