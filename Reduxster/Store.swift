//
//  Store.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import Foundation
import UIKit

var str = "Hello, playground"

public protocol Storable {
    associatedtype R: Reducer
    var state: State { get set }
    var reducer: R { get }
    var subscribers: [Subscriber] { get set }
    init(reducer: R)
    mutating func subscribe(s: Subscriber)
    mutating func unsubscribe(s: Subscriber)
    mutating func dispatchAction(action: Action)
    func updateSubscribers()
}

public extension Storable {
    mutating func dispatchAction(action: Action) {
        self.state = reducer.handleAction(action: action, state: state)
    }
    
    mutating func subscribe(s: Subscriber) {
        self.subscribers.append(s)
    }
    
    mutating func unsubscribe(s: Subscriber) {
        self.subscribers = self.subscribers.filter({$0 != s})
    }
    
    func updateSubscribers() {
        self.subscribers.forEach({$0.setState(state: self.state)})
    }
}

public struct Store<R:Reducer>: Storable {
    public var state: State {
        didSet {
            updateSubscribers()
        }
    }
    public let reducer: R
    public var subscribers: [Subscriber] = []
    public init(reducer: R) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
}
