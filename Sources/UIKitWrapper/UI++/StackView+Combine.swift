//
//  StackView+Combine.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 16.04.2021.
//

import UIKit
//import CombineCocoaRuntime
//import CombineCocoa
import CombineOperators

public protocol ViewConstrainstsSettable {
    
}
extension UIView: ViewConstrainstsSettable {
    
}
extension ViewConstrainstsSettable where Self: UIView {
    @discardableResult
    public func centerX(_ spacing: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {
        //        DispatchQueue.main.async {
        //            if let superview = self.superview {
        //
        //                self.translatesAutoresizingMaskIntoConstraints = false
        //                self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: spacing ?? 0).isActive = true
        //            }
        //        }
        
        
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
                    
                    self.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: superview, attribute: .centerX, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }
//                    self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: spacing ?? 0).isActive = true
                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func centerY(_ spacing: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
                    self.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: superview, attribute: .centerY, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

//                    self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: spacing ?? 0).isActive = true
                }
            }).store(in: self.cb.asBag)
        
        return self
    }
    
    @discardableResult
    public func width(percents: CGFloat = 100, plus: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
//                    self.widthAnchor.constraint(equalTo: superWidth, multiplier: percents/100, constant: plus).isActive = true
                    NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: superview, attribute: .width, multiplier: percents/100, constant: plus)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func height(percents: CGFloat = 100, plus: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
                    NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: superview, attribute: .height, multiplier: percents/100, constant: plus)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

//                    self.heightAnchor.constraint(equalTo: superHeight, multiplier: percents/100, constant: plus).isActive = true
                }
            }).store(in: self.cb.asBag)
        return self
    }

    @discardableResult
    public func width(_ width: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
                    //                    self.widthAnchor.constraint(equalTo: superWidth, multiplier: percents/100, constant: plus).isActive = true
                    NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .width, multiplier: 1, constant: width)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }
                }
            }).store(in: self.cb.asBag)
        return self
    }

    @discardableResult
    public func height(_ height: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                if let superview = self.superview {
                    NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .height, multiplier: 1, constant: height)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }
                    //                    self.heightAnchor.constraint(equalTo: superHeight, multiplier: percents/100, constant: plus).isActive = true
                }
            }).store(in: self.cb.asBag)
        return self
    }

    @discardableResult
    public func top(_ spacing: CGFloat?, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                self.translatesAutoresizingMaskIntoConstraints = false
                if let superview = self.superview {
//                    self.topAnchor.constraint(equalTo: superview.topAnchor, constant: spacing ?? 0).isActive = true
                    NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: superview, attribute: .top, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func bottom(_ spacing: CGFloat?, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                self.translatesAutoresizingMaskIntoConstraints = false
                if let superview = self.superview {
//                    self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -(spacing ?? 0)).isActive = true
                    NSLayoutConstraint(item: superview, attribute: .bottom, relatedBy: relation, toItem: self, attribute: .bottom, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func left(_ spacing: CGFloat?, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {

        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                self.translatesAutoresizingMaskIntoConstraints = false
                if let superview = self.superview {
                    NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: superview, attribute: .left, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

//                    self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: spacing ?? 0).isActive = true
                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func right(_ spacing: CGFloat?, _ relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> Self {
        cb.movedToSuperview.sink(
            receiveCompletion: {_ in },
            receiveValue: {
                self.translatesAutoresizingMaskIntoConstraints = false
                if let superview = self.superview {
//                    self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -(spacing ?? 0)).isActive = true
                    NSLayoutConstraint(item: superview, attribute: .right, relatedBy: relation, toItem: self, attribute: .right, multiplier: multiplier, constant: spacing ?? 0)
                        .apply {
                            $0.isActive = true
                            $0.priority = priority
                        }

                }
            }).store(in: self.cb.asBag)
        return self
    }
    
    @discardableResult
    public func fill() -> Self {
        _ = top(0)
            .bottom(0)
            .left(0)
            .right(0)
        return self
    }


    @discardableResult
    public func fillVertically() -> Self {
        _ = top(0)
            .bottom(0)
        return self
    }


    @discardableResult
    public func fillHorizontally() -> Self {
        _ = left(0)
            .right(0)
        return self
    }

}


extension ClosedRange: AnyUIView where Bound == Int {
    public var getView: UIView {
        UIView().apply { spacer in
            spacer.backgroundColor = .clear
            spacer.cb.movedToSuperview.sink(
                receiveCompletion: {_ in },
                receiveValue: {
                    guard let stack = spacer.superview as? UIStackView else { return }
                    if stack.axis == .vertical {
                        NSLayoutConstraint(item: spacer, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: stack, attribute: .height, multiplier: 1.0, constant: CGFloat(lowerBound)).isActive = true
                        NSLayoutConstraint(item: spacer, attribute: .height, relatedBy: .lessThanOrEqual, toItem: stack, attribute: .height, multiplier: 1.0, constant: CGFloat(upperBound)).isActive = true
                    } else {
                        NSLayoutConstraint(item: spacer, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: stack, attribute: .width, multiplier: 1.0, constant: CGFloat(lowerBound)).isActive = true
                        NSLayoutConstraint(item: spacer, attribute: .width, relatedBy: .lessThanOrEqual, toItem: stack, attribute: .width, multiplier: 1.0, constant: CGFloat(upperBound)).isActive = true
                    }
                }
            ).store(in: bag(spacer))

        }
    }
    
    
}
