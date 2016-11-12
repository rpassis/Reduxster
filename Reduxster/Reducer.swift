//
//  Reducer.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import Foundation

public protocol Reducer {
    var initialState: State { get }
    func handleAction(action: Action, state: State) -> State
}
