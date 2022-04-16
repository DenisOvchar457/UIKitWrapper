//
//  UIViewExt.swift
//  BORK.CRM
//
//  Created by work on 07/10/2018.
//  Copyright © 2018 work. All rights reserved.
//

import Foundation
import UIKit


public extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}



public extension UIView {
    func capture() -> UIImage? {
        var image: UIImage?
        
        if #available(iOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat()
            format.opaque = isOpaque
            let renderer = UIGraphicsImageRenderer(size: frame.size, format: format)
            image = renderer.image { context in
                drawHierarchy(in: frame, afterScreenUpdates: true)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, UIScreen.main.scale)
            drawHierarchy(in: frame, afterScreenUpdates: true)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        return image
    }
}




public extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}



public extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


public extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}

public extension UIView {
    var isShown: Bool {
        get { !isHidden }
        set {
            isHidden = !newValue
            alpha = newValue ? 1.0 : 0.0
        }
    }
}

public extension UIView {
    enum AnimationStyle {
        case top
        case right
        case left
        case bottom
        case fade
    }
    
    func transition(_ style: AnimationStyle = .fade, _ duration: TimeInterval = 0.3 , updateModel: ()->() ) {
        let transition = CATransition()
        let trasitionType: String = {
            switch style {
            case .top:
                return CATransitionSubtype.fromTop.rawValue
            case .right:
                return CATransitionSubtype.fromRight.rawValue
            case .left:
                return CATransitionSubtype.fromLeft.rawValue
            case .bottom:
                return CATransitionSubtype.fromBottom.rawValue
            case .fade:
                return CATransitionType.fade.rawValue
            }
        }()
        
        transition.type = CATransitionType(rawValue: trasitionType)
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = duration
        transition.subtype = CATransitionSubtype.fromTop
        self.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        updateModel()
        self.layoutSubviews()
    }
}
public extension UIView {
    var vResist: UILayoutPriority {
        get { contentCompressionResistancePriority(for: .vertical) }
        set { setContentCompressionResistancePriority(newValue, for: .vertical) }
    }
    var hResist: UILayoutPriority {
        get { contentCompressionResistancePriority(for: .horizontal) }
        set { setContentCompressionResistancePriority(newValue, for: .horizontal) }
    }
}

public extension UIView {
    func makeVisibleInScroll(insets: UIEdgeInsets = .of(top: 15, left: 15, bottom: 40, right: 15)) {
        if let scroll = findScrollInSuper() {
            scroll.scrollSubviewToBeVisible(subview: self, insets: insets, animated: true)
        }
    }
    
    func findScrollInSuper() -> UIScrollView? {
        if let superview = superview as? UIScrollView {
            return superview
        } else {
            return superview?.findScrollInSuper()
        }
    }
}

public extension UIView {
  public func addConstraintsSubview(_ subview: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    setNeedsUpdateConstraints()
	  
  }
	
	func findSuperview(_ condition: (UIView) -> Bool) -> UIView? {
		if condition(self) { return self }
		return self.superview?.findSuperview(condition) // .flatMap { condition($0) ? $0 : $0.findSuperview(condition) }
	}
}




//func recurFind<T, R>(initial: T, next: (T) -> [T], found: () -> R ) -> R {
//    if let next = next(initial) {
//
//    } else {
//
//    }
//}
