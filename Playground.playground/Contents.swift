//: Playground - noun: a place where people can play

import UIKit
import Reduxster

struct AppState: State {
    var searchText: String = ""
}

enum FMAction: Action {
    case searchText(String)
}

struct FMReducer: Reducer {
    var initialState: State { return AppState() }
    
    func handleAction(action: Action, state: State) -> State {
        guard let action = action as? FMAction, var fmState = state as? AppState else {
            return self.initialState
        }
        switch action {
        case .searchText(let text):
            fmState.searchText = text
        }
        return fmState
    }
}

var store = Store<FMReducer>(reducer: FMReducer())

class FMSubscriber:Subscriber {
    var state: State?
    let identifier: String = NSUUID().uuidString
    func setState(state: State) {
        if let state = state as? AppState {
            print("subscriber update called for identifier \(identifier)")
            print("search text is now \(state.searchText)")
        }
        self.state = state
    }
    
    func search(withText text: String) {
        let action = FMAction.searchText(text)
        store.dispatchAction(action: action)
    }
    
    func setup() {
        store.subscribe(self)
    }
    
    func tearUp() {
        store.unsubscribe(self)
    }
}

let sub1 = FMSubscriber()
store.subscribe(sub1)
sub1.search(withText: "abc")
