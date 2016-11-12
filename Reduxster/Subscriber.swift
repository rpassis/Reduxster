//
//  Subscriber.swift
//  Reduxster
//
//  Created by Rogerio de Paula Assis on 12/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import Foundation

public protocol Subscriber {
    var identifier: String { get }
    var state: State? { get set }
    func setState(state: State)
}

public func !=(lhs: Subscriber, rhs: Subscriber) -> Bool {
    return lhs.identifier != rhs.identifier
}
