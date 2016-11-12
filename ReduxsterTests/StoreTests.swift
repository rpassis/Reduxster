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
        let action = ConcreteActionTest()
        store.dispatchAction(action: action)
        XCTAssert((store.state as! ConcreteStateTest).testVarChanged == true)
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
        store.updateSubscribers()
        XCTAssertTrue(subscriber.subscriberSetStateCalled)
    }
}

struct ConcreteActionTest: Action {}
struct ConcreteStateTest: State {
    var testVarChanged: Bool = false
}

class ConcreteReducerTest: Reducer {
    var handleActionWasCalled = false
    var initialState: State = ConcreteStateTest()
    func handleAction(action: Action, state: State) -> State {
        var newState = state as! ConcreteStateTest
        newState.testVarChanged = true
        self.handleActionWasCalled = true
        return newState
    }
}

class ConcreteSubscriberTest: Subscriber {
    var identifier: String = "ABCDEFG"
    var state: State?
    var subscriberSetStateCalled = false
    func setState(state: State) {
        subscriberSetStateCalled = true
    }
}
