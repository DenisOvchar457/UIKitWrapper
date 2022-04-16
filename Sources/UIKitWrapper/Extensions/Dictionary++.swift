//
//  Dictionary++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 15.04.2021.
//

import Foundation
// swiftlint:disable shorthand_operator

func += <K, V> (left: inout [K: V], right: [K: V]) {
    left = left + right
}

func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    return left.merging(right, uniquingKeysWith: { _, rhs in rhs } )
}

public extension Dictionary {
    mutating func mutate(for key: Key, mutator: (inout Value?) -> Void) {
        var val = self[key]
        mutator(&val)
        self[key] = val
    }
}
