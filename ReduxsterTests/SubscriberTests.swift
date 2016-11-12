//
//  SubscriberTests.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import XCTest
@testable import Reduxster

class SubscriberTests: XCTestCase {
    
    var a: ConcreteSubscriberTest!
    var b: ConcreteSubscriberTest!
    
    override func setUp() {
        super.setUp()
        a = ConcreteSubscriberTest()
        b = ConcreteSubscriberTest()
    }
    
    override func tearDown() {
        super.tearDown()
        a = nil
        b = nil
    }
    
    func testInequality() {
        a.identifier = "A"
        b.identifier = "B"
        XCTAssert(a != b)
        b.identifier = "A"
        XCTAssertFalse(a != b)
    }
    
}
