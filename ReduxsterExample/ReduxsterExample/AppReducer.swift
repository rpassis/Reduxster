//
//  AppReducer.swift
//  ReduxsterExample
//
//  Created by Rogerio de Paula Assis on 13/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import Foundation
import Reduxster

struct AppReducer: Reducer {
    var initialState: State { return AppState() }
    
    func handleAction(action: Action, state: State) -> State {
        if let action = action as? AppAction, let state = state as? AppState {
            var newState = state
            switch action {
            case .testAction(let text):
                newState.textValue = text
            }
            return newState
        }
        return state
    }
}
