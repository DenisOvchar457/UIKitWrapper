//
//  Collection++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import Foundation

public extension Array {
    func filterDuplicate<T>(_ keyValue: (Element) -> T) -> [Element] {
        var uniqueKeys = Set<String>()
        return filter { uniqueKeys.insert("\(keyValue($0))").inserted }
    }
}

public extension Collection {
    func separated(_ elementsToInsert: () -> [Element] ) -> [Element] {
        var result: [Element] = []
        let count = self.count

        for (index, element) in self.enumerated() {
            result += [element]
            if index == count - 1 { break }
            result += elementsToInsert()
        }
        return result
    }
    func separated(_ separator: () -> Element ) -> [Element] {
        var result: [Element] = []
        let count = self.count

        for (index, element) in self.enumerated() {
            result += [element]
            if index == count - 1 { break }
            result.append(separator())
        }
        return result
    }
    func find<T>(ofType: T.Type) -> T? {
        for val in self {
            if let wanted = val as? T {
                return wanted
            }
        }
        return nil
    }
    
    func find<T>(_ condition: ((Element) -> T?)) -> T? {
        for value in self {
            if let condition = condition(value) {
                return condition
            }
        }
        return nil
    }
}

//public func +<T, C1: Collection, C2: Collection>(_ lhs: C1, _ rhs: C2) -> [T] where C1.Element == T, C2.Element == T {
//    var left = lhs.map { $0 }
//    left.append(contentsOf: rhs)
//    return left
//}

@discardableResult
public func += <T>(_ lhs: inout [T], _ rhs: T) -> [T] {
    lhs.append(rhs)
    return lhs
}

public func + <T>(_ lhs: [T], _ rhs: T) -> [T] {
    var left = lhs
    left.append(rhs)
    return left
}

public extension Array {

    subscript(safe index: Int) -> Element? {
        get {
            guard !isEmpty, index > -1, index < count else {
                return nil
            }
            return self[index]
        }
        set {
            guard let value = newValue, !isEmpty, index > -1, index < count else {
                return
            }
            self[index] = value
        }
    }

}
