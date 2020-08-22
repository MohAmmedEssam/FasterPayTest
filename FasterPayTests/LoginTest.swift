//
//  LoginTest.swift
//  FasterPayTests
//
//  Created by Mohammed Essam on 8/22/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import XCTest
@testable import FasterPay

class LoginTest: XCTestCase {

    var mail:String?
    var password:String?
    var viewModel:LoginVM?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mail = "Moh@essam.com"
        password = "Moh@essam.123"
        viewModel = LoginVM(mail: mail, password:password)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mail = nil
        password = nil
        viewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        viewModel?.tryLogin(){(user) in
            XCTAssertEqual(user.mail, self.mail)
            XCTAssertEqual(user.password, self.password)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
