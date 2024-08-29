//
//  CG+Adiitions.swift
//  FinesPayment
//
//  Created by Daniil on 24.05.2018.
//  Copyright © 2018 RosEuroBank. All rights reserved.
//

import UIKit

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2))
    }
}

