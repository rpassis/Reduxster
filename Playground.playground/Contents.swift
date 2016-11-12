//: Playground - noun: a place where people can play

import UIKit
import Reduxster

var str = "Hello, playground"

struct FMState: State {
    var counter: Int = 0
}

enum FMAction: Action {
    case increaseCounter(Int)
}

struct FMReducer: Reducer {
    var initialState: State { return FMState() }
    
    func handleAction(action: Action, state: State) -> State {
        guard let action = action as? FMAction, var fmState = state as? FMState else {
            return self.initialState
        }
        switch action {
        case .increaseCounter(let amount):
            fmState.counter = fmState.counter + amount
        }
        return fmState
    }
}

var store = Store<FMReducer>(reducer: FMReducer())

class FMSubscriber:Subscriber {
    var state: State?
    let identifier: String = NSUUID().uuidString
    func setState(state: State) {
        if let state = state as? FMState {
            print("subscriber update called for identifier \(identifier)")
            print("counter is now \(state.counter)")
            self.state = state
        }
    }
    
    func increaseCounter() {
        let action = FMAction.increaseCounter(10)
        store.dispatchAction(action: action)
    }
    
    func setup() {
        store.subscribe(s: self)
    }
    
    func tearUp() {
        store.unsubscribe(s: self)
    }
}

let sub1 = FMSubscriber()
let sub2 = FMSubscriber()
store.subscribe(s: sub1)
store.subscribe(s: sub2)
sub1.increaseCounter()
sub2.increaseCounter()
