//
//  File.swift
//  
//
//  Created by  Denis Ovchar on 26.11.2023.
//

import UIKit



/// GestureRecognizer, который обрабатывает все нажатия
public class TouchGestureRecognizer: UIGestureRecognizer {

    var cancelWhenOutside = true

    override public func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
        print(#function)

    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        print(#function)

        guard let view = view, let point = Array(touches).last?.location(in: view) else {
            return
        }

        if view.bounds.contains(point) {
            self.state = .changed
        } else if cancelWhenOutside {
            self.state = .cancelled
        }
    }

    public override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent) {
        super.pressesChanged(presses, with: event)
        print(#function)
        print(presses)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print(#function)
        self.state = .ended
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        print(#function)
        self.state = .cancelled
    }
}


public class ContiniusGestureRecognizer: UIGestureRecognizer {

    var cancelWhenOutside = true

    override public func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
        print(#function)

    }

    public override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent) {
        super.pressesChanged(presses, with: event)
        print(#function)
        print(presses)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print(#function)
//        self.state = .ended
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        print(#function)
//        self.state = .cancelled
    }
}



public final class HighlightingGestureRecognizer: UIGestureRecognizer {

    private let onPressed:((_ gestureRecognizer: UIGestureRecognizer) -> Void)?
    private let onReleased:((_ gestureRecognizer: UIGestureRecognizer) -> Void)?

    @objc public init(onPressed:@escaping ((_ gestureRecognizer: UIGestureRecognizer) -> Void),
                      onReleased: @escaping((_ gestureRecognizer: UIGestureRecognizer) -> Void)) {
        self.onPressed = onPressed
        self.onReleased = onReleased
        super.init(target: nil, action: nil)

        delaysTouchesBegan = false
        delaysTouchesEnded = false

//        self.addTarget(self, action: #selector(handleHighlighting(_:)))
    }

    // MARK: - Highlighting handler

//    @objc private func handleHighlighting(_ gestureRecognizer: UIGestureRecognizer) {
//        handler?(gestureRecognizer)
//    }


    override public func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }



    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesBegan(touches, with: event)
        self.state = .began
//        DispatchQueue.main.async {

            self.onPressed?(self)
//        }
        print(#function)

    }

    public override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent) {
//        super.pressesChanged(presses, with: event)
        print(#function)
        print(presses)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesEnded(touches, with: event)
        print(#function)
//        DispatchQueue.main.async {
            self.onReleased?(self)
//        }
        //        self.state = .ended
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesCancelled(touches, with: event)
        print(#function)
        //        self.state = .cancelled
    }

}
