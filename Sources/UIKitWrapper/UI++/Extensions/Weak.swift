//
//  Weak.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 28.04.2021.
//

import Foundation

public class Weak<T: AnyObject> {
    weak public var value: T?
    
    public init(_ value: T) {
        self.value = value
    }
}
