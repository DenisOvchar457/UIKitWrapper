//
//  CGPoint ++.swift
//  Prometheus_iOS7x
//
//  Created by Овчар Денис on 06/08/2018.
//  Copyright © 2018 PochtaBank. All rights reserved.
//

import UIKit
public extension CGPoint {
    func x(_ value: CGFloat) -> CGPoint {
        return CGPoint(x: x + value, y: y)
    }
    func y(_ value: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y + value)
    }
}
