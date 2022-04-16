//
//  SelectorHandler.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import UIKit

public class SelectorHandler<In>: NSObject {

    let block: (In) -> Void

    @discardableResult init (referenceHolder: AnyObject, block: @escaping (In) -> Void) {
        self.block = block
        super.init()

        var kSomeKey = "s"
        // Закидываем рекогнайзер к вьюхе, что бы arc не убивал его пока он нужен
        objc_setAssociatedObject(referenceHolder, &kSomeKey, self, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc func handle(sender: Any) {
        (sender as? In).map(block)
    }

    deinit {
        print("SelectorHandler Deinit")
    }
}

public extension UIView {
	public  func onTap(_ action: @escaping () -> Void) -> Self {
        let handler = SelectorHandler<UITapGestureRecognizer>(referenceHolder: self) { _ in action() }
        let gestureRcognizer = UITapGestureRecognizer(target: handler, action: #selector(handler.handle(sender:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(gestureRcognizer)
        gestureRcognizer.cancelsTouchesInView = false
        return self
    }
    
	public func onTap(_ action: @escaping (Self) -> Void) -> Self {
        onTap {
            action(self)
        }
    }
}
