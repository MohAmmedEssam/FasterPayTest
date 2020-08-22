//
//  RegisterTest.swift
//  FasterPayTests
//
//  Created by Mohammed Essam on 8/22/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import XCTest
@testable import FasterPay

class RegisterTest: XCTestCase {

    var mail:String?
    var password:String?
    var firstName:String?
    var lastName:String?
    var viewModel:RegisterVM?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mail = "Moh@essam.com"
        password = "Moh@essam.123"
        firstName = "Moh"
        lastName = "Essam"
        viewModel = RegisterVM(mail: mail,
                               password:password,
                               firstName:firstName,
                               lastName:lastName,
                               isSwitchOn:true)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mail = nil
        password = nil
        firstName = nil
        lastName = nil
        viewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        viewModel?.tryRegister(){(user) in
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
