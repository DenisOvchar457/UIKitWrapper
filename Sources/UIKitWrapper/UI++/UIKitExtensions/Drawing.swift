//
//  Drawing.swift
//  CheqApp
//
//  Created by Овчар Денис on 01/10/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

#if canImport(UIKit) && os(iOS)
import UIKit

public extension UIView {
//    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, dashLenght: CGFloat, spaceLenght: CGFloat) {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor.lightGray.cgColor
//        shapeLayer.lineWidth = 1
//        shapeLayer.lineDashPattern = [dashLenght, spaceLenght] as [NSNumber] // 7 is the length of dash, 3 is length of the gap.
//
//        let path = CGMutablePath()
//        path.addLines(between: [p0, p1])
//        shapeLayer.path = path
//        self.layer.addSublayer(shapeLayer)
//    }
    
//    func lines(color: UIColor, width: UIColor, _ points: CGPoint...) {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.lineWidth = 1
//
//        let path = CGMutablePath()
//        path.addLines(between: points)
//        shapeLayer.path = path
//        self.layer.addSublayer(shapeLayer)
//    }
    
    func lines(color: UIColor, fillColor: UIColor = .clear, width: CGFloat, _ point: CGPoint, _ offsetPoints: CGPoint...) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.fillColor = fillColor.cgColor

        let path = CGMutablePath()
        var points = [point]
        for point in offsetPoints {
            points.append(points.last!.x(point.x).y(point.y))
        }
        
        path.addLines(between:  points )
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
	
//	func path()
}
#endif


#if canImport(UIKit)
import Foundation
//extension CGPoint {
    public func xy(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        .init(x: x, y: y)
    }
//}



public extension CGSize {
    static func wh(_ w: CGFloat,_ h: CGFloat) -> CGSize {
        CGSize(width: w, height: h)
    }
}
#endif
