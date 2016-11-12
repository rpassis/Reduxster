//
//  StorableTests.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import XCTest

@testable import Reduxster

class StorableTests: XCTestCase {
    
    var store: Store<ConcreteReducerTest>!
    var subscriber: ConcreteSubscriberTest!
    
    override func setUp() {
        super.setUp()
        let reducer = ConcreteReducerTest()
        subscriber = ConcreteSubscriberTest()
        store = Store(reducer: reducer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        store = nil
        super.tearDown()
    }
    
    func testDispatchAction() {
        store.subscribe(subscriber)
        XCTAssertFalse((store.state as! ConcreteStateTest).testVarChanged)
        XCTAssertFalse(subscriber.subscriberSetStateCalled)
        let action = ConcreteActionTest()
        store.dispatchAction(action: action)
        XCTAssertTrue((store.state as! ConcreteStateTest).testVarChanged)
        XCTAssertTrue(subscriber.subscriberSetStateCalled)
    }
    
    func testSubscribe() {
        XCTAssert(store.subscribers.count == 0)
        store.subscribe(subscriber)
        XCTAssert(store.subscribers.count == 1)
        let s = store.subscribers.first as! ConcreteSubscriberTest
        XCTAssertFalse(s != subscriber)
    }
    
    func testUnsubscribe() {
        store.subscribe(subscriber)
        XCTAssert(store.subscribers.count == 1)
        store.unsubscribe(subscriber)
        XCTAssert(store.subscribers.count == 0)
    }
    
    func testUpdateSubscribers() {
        store.subscribe(subscriber)
        XCTAssertFalse(subscriber.subscriberSetStateCalled)
        store.updateSubscribers()
        XCTAssertTrue(subscriber.subscriberSetStateCalled)
    }
    
    func testSetStateUpdatesSubscribers() {
        store.subscribe(subscriber)
        XCTAssertFalse(subscriber.subscriberSetStateCalled)
        let state = ConcreteStateTest()
        store.state = state
        XCTAssertTrue(subscriber.subscriberSetStateCalled)
    }
}
