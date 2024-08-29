//
//  CGPoint ++.swift
//  Prometheus_iOS7x
//
//  Created by Овчар Денис on 06/08/2018.
//  Copyright © 2018 PochtaBank. All rights reserved.
//

import UIKit
public extension CGPoint {
    func x(_ adding: CGFloat) -> CGPoint {
        return CGPoint(x: x + adding, y: y)
    }
    func y(_ adding: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y + adding)
    }
}
