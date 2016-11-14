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
    mutating func subscribe(_ subscriber: Subscriber)
    mutating func unsubscribe(_ subscriber: Subscriber)
    mutating func dispatch(_ action: Action)
    mutating func dispatch(_ actionCreator: ActionCreator) -> Action?
    func updateSubscribers()
}

public extension Storable {
    
    typealias ActionCreator = (_ state: State, _ store: Store<R>) -> Action?
    
    mutating func dispatch(_ action: Action) {
        self.state = reducer.handleAction(action: action, state: state)
    }
    
    mutating func dispatch(_ actionCreator: ActionCreator) -> Action? {
        guard let action = actionCreator(self.state, self as! Store<R>) else {
            return nil
        }
        dispatch(action)
        return action
    }
    
    mutating func subscribe(_ subscriber: Subscriber) {
        self.subscribers.append(subscriber)
        self.updateSubscribers()
    }
    
    mutating func unsubscribe(_ subscriber: Subscriber) {
        self.subscribers = self.subscribers.filter({$0 != subscriber})
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
