//
//  UIControl++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 16.04.2021.
//

import UIKit

// MARK: UIControl Block based actions
public typealias ActionBlock = (UIControl) -> ()

public class UIButtonActionDelegate : NSObject {
    let actionBlock : ActionBlock
    init(actionBlock: @escaping ActionBlock) {
        self.actionBlock = actionBlock
    }
    @objc func triggerBlock(control : UIControl) {
        actionBlock(control)
    }
}

private var actionHandlersKey: UInt8 = 0
public extension UIControl {
    var actionHandlers: NSMutableArray { // cat is *effectively* a stored property
        get {
            return associatedObject(base: self, key: &actionHandlersKey, initialiser: { () -> NSMutableArray in
                return NSMutableArray()
            })
        }
        set { associateObject(base: self, key: &actionHandlersKey, value: newValue) }
    }
    
    func on(event: UIControl.Event, block: @escaping ActionBlock) {
        let actionDelegate = UIButtonActionDelegate(actionBlock: block)
        actionHandlers.add(actionDelegate) // So it gets retained
        addTarget(actionDelegate, action: #selector(UIButtonActionDelegate.triggerBlock(control:)), for: event)
    }
}
