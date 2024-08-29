//
//  CGRect ++.swift
//  Prometheus_iOS7x
//
//  Created by Овчар Денис on 06/08/2018.
//  Copyright © 2018 PochtaBank. All rights reserved.
//

import UIKit
public extension CGRect {
    var leftTop: CGPoint { return CGPoint(x: self.minX, y: self.minY) }
    var rightTop: CGPoint { return CGPoint(x: self.maxX, y: self.minY) }
    var rightBottom: CGPoint { return CGPoint(x: self.maxX, y: self.maxY) }
    var leftBottom: CGPoint { return CGPoint(x: self.minX, y: self.maxY) }
    
    
    func x(_ adding: CGFloat) -> CGRect {
        return CGRect(x: minX + adding, y: minY , width: width, height: height)
    }
    
    func y(_ adding: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY + adding , width: width, height: height)
    }
    
}
