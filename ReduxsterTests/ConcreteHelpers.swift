//
//  ConcreteHelpers.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import Foundation
@testable import Reduxster

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
