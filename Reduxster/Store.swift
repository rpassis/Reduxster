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
    var state: State { get set }
    var reducer: Reducer { get }
    var subscribers: [Subscriber] { get set }
    init(reducer: Reducer)
    mutating func subscribe(_ subscriber: Subscriber)
    mutating func unsubscribe(_ subscriber: Subscriber)
    mutating func dispatch(_ action: Action)
    mutating func dispatch(_ actionCreator: ActionCreator) -> Action?
    func updateSubscribers()
}

public extension Storable {
    
    typealias ActionCreator = (_ state: State, _ store: Store) -> Action?
    
    mutating func dispatch(_ action: Action) {
        self.state = reducer.handleAction(action: action, state: state)
    }
    
    @discardableResult
    mutating func dispatch(_ actionCreator: ActionCreator) -> Action? {
        guard let action = actionCreator(self.state, self as! Store) else {
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

public struct Store: Storable {
    public var state: State {
        didSet {
            updateSubscribers()
        }
    }
    public let reducer: Reducer
    public var subscribers: [Subscriber] = []
    public init(reducer: Reducer) {
        self.reducer = reducer
        self.state = reducer.initialState
    }
    
    }
