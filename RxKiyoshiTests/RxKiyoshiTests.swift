//
//  RxKiyoshiTests.swift
//  RxKiyoshiTests
//
//  Created by Yuki Yoshioka on 2017/05/04.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import XCTest
@testable import RxKiyoshi

class RxKiyoshiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDokoModel() {
        let zdk = ZunDoko.create(val: .doko)
        XCTAssert(zdk.toString() == "ドコ")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
