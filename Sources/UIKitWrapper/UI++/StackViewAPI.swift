//
//  StackViewAPI.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//
// swiftlint:disable all

import UIKit
//import RxSwift
//import RxOperators
//import RxCocoa
//import Carbon
//import RxKeyboard
import FoundationExtensions
import SwiftUI
import CombineOperators

public protocol AnyUIView {
    var getView: UIView { get }
    
    var height: CGFloat? { get }
    var width: CGFloat? { get }
    
}

typealias StackItem = AnyUIView

public extension AnyUIView {
    var height: CGFloat? { nil }
    var width: CGFloat? { nil }
}

public extension UIView {
    func wrappedInContainer(
        _ container: AnyUIView = UIView()
    ) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false

        return container.getView.apply {
//            $0.constraints.first { $0.firstItem = self && $0.secondItem = superview  }
            $0.addSubview(
                self
//                    .top(0, priority: .fittingSizeLevel)
//                    .left(0, priority: .fittingSizeLevel)
//                    .right(0, priority: .fittingSizeLevel)
//                    .bottom(0, priority: .fittingSizeLevel)


//                top.map { self.top($0) }
                //        left.map { self.left($0) }
                //        right.map { self.right($0) }
                //        bottom.map { self.bottom($0) }

            )
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

//    func paddingContainer(
//        container: AnyUIView = UIView(),
//        top: CGFloat? = nil,
//        left: CGFloat? = nil,
//        right: CGFloat? = nil,
//        bottom: CGFloat? = nil,
//        centerX: CGFloat? = nil,
//        centerY: CGFloat? = nil
//    ) -> UIView {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        return container.getView.apply {
//            //            $0.constraints.first { $0.firstItem = self && $0.secondItem = superview  }
//            $0.addSubview(
//                self
//                    .top(0, priority: UILayoutPriority.custom(1))
//                    .left(0, priority: UILayoutPriority.custom(1))
//                    .right(0, priority: UILayoutPriority.custom(1))
//                    .bottom(0, priority: UILayoutPriority.custom(1))
//
//
//                top.map { self.top($0) }
//                //        left.map { self.left($0) }
//                //        right.map { self.right($0) }
//                //        bottom.map { self.bottom($0) }
//
//            )
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }



//    func wrappedInContainerPinning(
//        container: AnyUIView = UIView(),
//        
//
//
//
//    ) -> UIView {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        return container.getView.apply {
//            $0.addSubview(self)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }


//    func wrappedInContainer(container: AnyUIView = UIView()) -> UIView {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        return container.getView.apply {
//            $0.addSubview(self)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }

//    public func wrappedInContainerPinning(_ top: CGFloat?,
//                      _ middle: (left: CGFloat?, right: CGFloat?),
//                      _ bottom: CGFloat?,
//                                          midY: CGFloat? = nil,
//                                                  midX: CGFloat? = nil,
//                      _ container: AnyUIView? = nil) -> UIView {
//        let containerView = container?.getView
//        containerView?.isUserInteractionEnabled = true
//
//        return (containerView ?? UIView()).apply { outer in
//            outer.addSubview(self)
//            self.translatesAutoresizingMaskIntoConstraints = false
//
//            fillToSuperview(top: top, left: middle.left, right: middle.right, bottom: bottom)
//        }
//    }

//    public func align(
//        top: CGFloat? = 0,
////        left: CGFloat? = 0,
////        right: CGFloat? = 0,
//        bottom: CGFloat? = 0,
//        midY: CGFloat? = nil,
//        midX: CGFloat? = nil
//    ) -> UIView {
//
//    }
//    enum HorizontalAlignment {
//        case horizontal
//        case vertical
//    }
//
//    public func align(
//        horizontal:
//        vetrical:
//margins
//
//        top: CGFloat? = 0,
//        left: CGFloat? = 0,
//        right: CGFloat? = 0,
//        bottom: CGFloat? = 0,
//        midY: CGFloat? = nil,
//        midX: CGFloat? = nil,
//        _ container: AnyUIView? = nil
//    ) -> UIView
//    {
//        let containerView = container?.getView
//        containerView?.isUserInteractionEnabled = true
//
//        return (containerView ?? UIView()).apply { outer in
//            outer.addSubview(self)
//            self.translatesAutoresizingMaskIntoConstraints = false
//
//            fillToSuperview(top: top, left: middle.left, right: middle.right, bottom: bottom)
//        }
////        self.under(top, (left , right), bottom, container)
//    }

//    public func pinHorizontally(
//        top: CGFloat? = 0,
//        bottom: CGFloat? = 0,
//        centerX: CGFloat? = nil
//    ) -> UIView
//    {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        top.map { self.top($0) }
//        bottom.map { self.bottom($0) }
//        centerX.map { self.centerX($0) }
//
//        return self
//    }
//
//    public func fillHorizontally(
//        left: CGFloat? = 0,
//        right: CGFloat? = 0,
//        centerY: CGFloat? = nil
//    ) -> UIView
//    {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        left.map { self.left($0) }
//        right.map { self.right($0) }
//        centerY.map { self.centerY($0) }
//
//        return self
//    }
//
//    public func huggingSuperview(
//        top: CGFloat? = 0,
//        left: CGFloat? = 0,
//        right: CGFloat? = 0,
//        bottom: CGFloat? = 0
//    ) -> UIView
//    {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        top.map { self.top($0) }
//        left.map { self.left($0) }
//        right.map { self.right($0) }
//        bottom.map { self.bottom($0) }
//
//        return self
//    }
//
//    public func position(
//
//                centerX: CGFloat? = nil,
//                centerY: CGFloat? = nil
//    ) -> UIView
//    {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        centerX.map { self.centerX($0) }
//        centerY.map { self.centerY($0) }
//
//        return self
//    }


        public func inPaddingContainer(
            top: CGFloat? = nil,
            left: CGFloat? = nil,
            right: CGFloat? = nil,
            bottom: CGFloat? = nil,
            container: AnyUIView? = nil
        ) -> UIView
        {
            let containerView = container?.getView

            self.translatesAutoresizingMaskIntoConstraints = false
    
            top.map { self.top($0) }
            left.map { self.left($0) }
            right.map { self.right($0) }
            bottom.map { self.bottom($0) }
    
            return (containerView ?? UIView()).apply { outer in
                outer.addSubview(self)
                self.translatesAutoresizingMaskIntoConstraints = false
                outer.translatesAutoresizingMaskIntoConstraints = false
            }
        }

    public func inPaddingContainer(_ top: CGFloat?,
                                   _ middle: (left: CGFloat?, right: CGFloat?),
                                   _ bottom: CGFloat?,
                                   container: AnyUIView? = nil) -> UIView {
        let containerView = container?.getView
        //        containerView?.isUserInteractionEnabled = true

        return (containerView ?? UIView()).apply { outer in
            outer.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            outer.translatesAutoresizingMaskIntoConstraints = false

            fillToSuperview(top: top, left: middle.left, right: middle.right, bottom: bottom)
        }
    }
}

public extension UIView {
//    public horizontally(left:

    public func paddings(
        _ top: CGFloat? = nil,
        _ middle: (left: CGFloat?, right: CGFloat?)? = nil,
        _ bottom: CGFloat? = nil
    ) -> Self
    {
        self.translatesAutoresizingMaskIntoConstraints = false

        top.map { self.top($0) }
        middle?.left.map { self.left($0) }
        middle?.right.map { self.right($0) }
        bottom.map { self.bottom($0) }

        return self
    }
}

extension UIStackView {
    public func margins(
        _ top: CGFloat = 0,
        _ middle: (left: CGFloat, right: CGFloat) = (0,0),
        _ bottom: CGFloat = 0
    ) -> Self
    {

        self.layoutMargins = UIEdgeInsets(top: top, left: middle.left, bottom: bottom, right: middle.right)
        self.isLayoutMarginsRelativeArrangement = true

        return self
    }
}

public func V(_ items: AnyUIView...) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items)
    }
}


//public func VV(_ items: [AnyUIView])  -> UIStackView {
//    UIStackView().apply {
//        $0.setV(items: items)
//    }
//}

public func V(@StackBuilder items: ()->[AnyUIView]) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items())
    }
}

public func Z( _ items: AnyUIView...) -> UIView {
    let view = UIView()
    for item in items {
        let itemView = item.getView
        view.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
//        view.trailingAnchor.constraint(lessThanOrEqualTo: itemView.trailingAnchor).isActive = true
//        view.leadingAnchor.constraint(lessThanOrEqualTo: itemView.leadingAnchor).isActive = true
//        view.topAnchor.constraint(lessThanOrEqualTo: itemView.topAnchor).isActive = true
//        view.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor).isActive = true


//        view.fillToSuperview()
//        left.map { leftAnchor.constraint(equalTo: superview.leftAnchor, constant: $0).isActive = true }
//        itemView.fillToSuperview()
    }
    view.translatesAutoresizingMaskIntoConstraints = false
    
    
    return view
}

public extension UIView {
    public func forContent(_ block: (UIView) -> () ) -> Self {
        subviews.forEach (block)
        return self
    }
}

public extension UIStackView {
    public func debugColorize() -> Self {
        zip(
            [.red, .green, .blue, .red, .green, .blue, .red, .green, .blue],
            arrangedSubviews
        )
        .forEach {
            $0.1.backgroundColor = $0.0
        }
        return self
    }
}

//public extension UIView {
//    public func debugHighlight() -> Self {
//        self[border: (1, .yellow)]
//    }
//}

//public func Z(@Builder<AnyUIView> items: ()->[AnyUIView]) -> UIView {
//    let view = UIView()
//    for item in items() {
//        let itemView = item.getView
////        itemView.isUserInteractionEnabled = true
//        view.addSubview(itemView)
//        itemView.fillToSuperview()
//    }
//    return view
//}

public func VList(_ items: [AnyUIView]) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items)
    }
}

//public func VList<O: ObservableType>(_ observableItems: O, row: (O.Element) -> AnyUIView ) -> UIStackView {
//    VListRx(observableItems.map { row($0) })
//}

public func HList(_ items: [AnyUIView]) -> UIStackView {
    UIStackView().apply {
        $0.setH(items: items)
    }
}

public func H(_ items: AnyUIView...) -> UIStackView {
    UIStackView().apply {
        
        $0.setH(items: items)
    }
}
public func H(@StackBuilder items: ()->[AnyUIView]) -> UIStackView {
    UIStackView().apply { $0.setH(items: items()) }
}

//TODO: Группы extension [AnyUIView]: AnyUIView

//public func Z(@Builder<ItemHV> items: ()->[ItemHV]) -> UIView {
//    UIView().apply { view in
//        for item in items() {
//            let newView = item.getView
//            view.addSubview(newView)
//            newView.fillToSuperview(bottom: nil)
//            newView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
//
//        }
//    }
//}


public extension UIView {
    var uiStyle: UIUserInterfaceStyle {
        get {
            overrideUserInterfaceStyle
        }
        set {
            overrideUserInterfaceStyle = newValue
        }
    }
}

public extension UIStackView {
    func setV(_ items: AnyUIView...) {
        setV(items: items)
    }
    func setV(items: [AnyUIView]) {
        axis = .vertical
        subviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
       
        let itemsAndViews = items.map { (item: $0, view: $0.getView) }
        for element in itemsAndViews {
            element.item.height.map {
                element.view.translatesAutoresizingMaskIntoConstraints = false
                element.view.heightAnchor.constraint(equalToConstant: $0).isActive = true
            }
            addArrangedSubview(element.view)
        }
        
        let spacers = itemsAndViews
            .map { $0.view }
            .filter { $0.tag == spacerTag }
        
//        spacers.forEach { $0.setContentHuggingPriority(.defaultLow, for:.vertical) }

        if spacers.count >= 2 {
            for spacer in spacers.dropFirst() {
                let constr = spacers.first?.heightAnchor.constraint(equalTo: spacer.heightAnchor, multiplier: 1.0)
//                constr?.priority = .defaultLow
                constr?.isActive = true
            }
        }
    }
    
    func setH(_ items: AnyUIView...) {
        setH(items: items)
    }
    func setH(items: [AnyUIView]) {
        axis = .horizontal
        subviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
       
        let itemsAndViews = items.map { (item: $0, view: $0.getView) }
        for element in itemsAndViews {
            element.item.width.map {
                element.view.translatesAutoresizingMaskIntoConstraints = false
                element.view.widthAnchor.constraint(equalToConstant: $0).isActive = true
            }
            addArrangedSubview(element.view)
        }
       
        let spacers = itemsAndViews
            .map { $0.view }
            .filter { $0.tag == spacerTag }
        if spacers.count >= 2 {
            for spacer in spacers.dropFirst() {
                let constr = spacers.first?.widthAnchor.constraint(equalTo: spacer.widthAnchor, multiplier: 1.0)
//                constr?.priority = .defaultLow
                constr?.isActive = true
            }
        }

    }
    
    
}

extension Optional: AnyUIView where Wrapped: AnyUIView {
	public var getView: UIView {
        self.map { $0.getView } ?? __
    }
    
	public var height: CGFloat? {
        self == nil ? 0 : nil
    }
    
	public var width: CGFloat? {
        self == nil ? 0 : nil
    }
}

public extension Array where Element: AnyUIView {
    public var hStack: UIView { UIStackView().apply { $0.setH(items: self) } }
    public var vStack: UIView { UIStackView().apply { $0.setV(items: self) } }
}


public extension Sequence {
    func vStack(selection: ((Element) -> ())? = nil, separator: @escaping @autoclosure () -> UIView? = nil , row: @escaping (Element) -> UIView)      -> UIStackView
    {
        let sep = separator()
        let stack = UIStackView()
        let list = self.map { el in row(el).onTap { selection?(el) } }
        if sep != nil {
            stack.setV(items: list.separated { separator() ?? __ } )
        } else {
            stack.setV(items: list )
        }
        return stack
    }
    func hStack(selection: ((Element) -> ())? = nil, separator: @escaping @autoclosure () -> UIView? = nil , row: @escaping (Element) -> UIView)      -> UIStackView
    {
        let sep = separator()
        let stack = UIStackView()
        let list = self.map { el in row(el).onTap { selection?(el) } }
        if sep != nil {
            stack.setH(items: list.separated { separator() ?? __ } )
        } else {
            stack.setH(items: list )
        }
        return stack
    }
}



//public func VListRx<O: ObservableType>(_ observableItems: O) -> UIStackView where O.Element == [UIView] {
//    UIStackView().apply { stack in
//        observableItems ==> { stack.setV(items: $0) } => stack.rx.asDisposeBag
//    }
//}



 extension Int: AnyUIView {
	public var height: CGFloat? {
        CGFloat(self)
    }
	public var getView: UIView {
        UIView().apply { $0.backgroundColor = .clear }
    }
	public var width: CGFloat? {
        CGFloat(self)
    }
}

public extension UIScreen {
    static var width: CGFloat { UIScreen.main.bounds.width }
    static var height: CGFloat { UIScreen.main.bounds.height }
}

 extension CGFloat: AnyUIView {
	 public var height: CGFloat? {
        self
    }

	 public var getView: UIView {
        UIView().apply { $0.backgroundColor = .clear }
    }
	 public var width: CGFloat? {
        self
    }
}

 extension Double: AnyUIView {
	 public var height: CGFloat? {
        CGFloat(self)
    }

	 public var getView: UIView {
        UIView().apply { $0.backgroundColor = .clear }
    }
	 public var width: CGFloat? {
        CGFloat(self)
    }
}



 extension String: AnyUIView {

	 public var getView: UIView {
		 UILabel().apply {
			 $0.text = self
		 }
	 }

}

public func space() -> UIView {
    UIView().apply { $0.backgroundColor = .clear }
}


 extension UIView: AnyUIView {
	 public var getView: UIView { self }
}


public protocol ViewExtension {}
 extension UIView: ViewExtension {}

//TODO: в этом порядке не закрашивается стэквью например )[color: .backgroundBlue].chain.alignment[.center]

public extension ViewExtension where Self: UIView {
    subscript(color color: UIColor? = nil, width width: CGFloat? = nil, height height: CGFloat? = nil, rad radius: CGFloat? = nil, border border: (w: CGFloat, color: UIColor)? = nil) -> Self {
//        if let stack = self as? UIStackView {
//            return stack[color: color, width: width, height: height, rad: radius, border: border] as! Self
//        }
        height.map {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: $0).isActive = true
        }
        width.map {
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor.constraint(equalToConstant: $0).isActive = true
        }
        
        color.map { color in
            self.backgroundColor = color
        }
        
        
        radius.map {
            self.layer.cornerRadius = $0
            self.layer.masksToBounds = true
        }
        
        border.map {
            self.layer.borderWidth = $0.w
            self.layer.borderColor = $0.color.cgColor
            self.layer.masksToBounds = true
        }
        return self
    }
    
    
    
    subscript(action: @escaping()->()) -> Self {
        onTap (action)
    }
}

public extension UIStackView {
     subscript(color color: UIColor? = nil, width width: CGFloat? = nil, height height: CGFloat? = nil, rad radius: CGFloat? = nil, border border: (w: CGFloat, color: UIColor)? = nil) -> UIView {
        height.map {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: $0).isActive = true
        }
        width.map {
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor.constraint(equalToConstant: $0).isActive = true
        }
        
        color.map { color in
            self.backgroundColor = color
        }
        radius.map {
            self.layer.cornerRadius = $0
            self.layer.masksToBounds = true
        }
        border.map {
            self.layer.borderWidth = $0.w
            self.layer.borderColor = $0.color.cgColor
            self.layer.masksToBounds = true
        }
        if #available(iOS 14, *) {
            return self
        } else if color != nil || radius != nil || border != nil {
            return self.fill().wrappedInContainer()[color: color, width: width, height: height, rad: radius, border: border]
        }

        return self
    }
}

public extension UIStackView {
    var contentV: [AnyUIView] {
        get { arrangedSubviews }
        set { setV(items: newValue) }
    }
    
    var contentH: [AnyUIView] {
        get { arrangedSubviews }
        set { setH(items: newValue) }
    }
}
public extension UITextField {
    var editing: Bool {
        get { isFirstResponder }
        set { newValue ? becomeFirstResponder() : resignFirstResponder() }
    }
}

public extension UIView {
    public func fillToSuperview(top: CGFloat? = 0, left: CGFloat? = 0, right: CGFloat? = 0, bottom: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            left.map { leftAnchor.constraint(equalTo: superview.leftAnchor, constant: $0).isActive = true }
            right.map { rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -$0).isActive = true }
            top.map { topAnchor.constraint(equalTo: superview.topAnchor, constant: $0).isActive = true }
            bottom.map { bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -$0).isActive = true }
        }
    }
}

public extension UIView {
    
    @discardableResult public func addingSubviews(_ views: UIView...) -> Self {
        views.forEach(addSubview)
        return self
    }
}

public func |(_ lhs: AnyUIView, _ rhs: AnyUIView) -> HorizontalChainer {
    HorizontalChainer(array: [lhs, rhs])
}

public func |(_ lhs: HorizontalChainer, _ rhs: AnyUIView) -> HorizontalChainer {
    HorizontalChainer(array: lhs.array + rhs)
}

 extension UIImage: AnyUIView {
	public var getView: UIView {
		UIImageView().apply {
			$0.contentMode = .scaleAspectFit
			$0.image = self
		}
	}
	public var height: CGFloat? { nil }
	public var width: CGFloat? { nil }
}


public struct HorizontalChainer: AnyUIView {
	public var width: CGFloat? { nil }
    
	public var height: CGFloat? { nil }
	public var lambda: ((UIStackView) -> ())?
	public var getView: UIView { UIStackView().apply { $0.setH(items: array) } }
    
    var array: [AnyUIView]
}

//extension UIImage {
//    subscript(color: UIColor? = nil, h height: CGFloat? = nil, w width: CGFloat? = nil, rad radius: CGFloat? = nil, contentMode: UIView.ContentMode? = nil) -> UIImageView {
//        UIImageView().chain
//            .contentMode[contentMode ?? .scaleAspectFit]
//            .image[self][color, h: height, w: width, rad: radius]
//    }
//}


let spacerTag = 987
public var __: UIView { UIView().apply { $0.backgroundColor = .clear; $0.tag = spacerTag } }

public func EqualSpacer() -> UIView {
    __
}

@_functionBuilder
public struct Vert {

  static public func buildBlock(_ segments: AnyUIView...) -> UIStackView {
    UIStackView().apply { $0.setV(items: segments) }
  }
    
    static public func buildBlock(_ segments: AnyUIView) -> UIStackView {
      UIStackView().apply { $0.setV(items: [segments]) }
    }
}
@_functionBuilder
public struct Horiz {
  static public func buildBlock(_ segments: AnyUIView...) -> UIStackView {
    UIStackView().apply { $0.setH(items: segments) }
  }
}

//@_functionBuilder
//struct ArrayBuilder<T> {
//  static public func buildBlock(_ segments: T...) -> [T] {
//    segments
//  }
//}

@resultBuilder
public struct Builder<T> {
	static public func buildBlock(_ segment: T) -> T {
		segment
	}
}


public extension Builder {
		static public func buildEither(first: T) -> T {
				first
		}

		static public func buildEither(second: T) -> T {
				second
		}
}

//@resultBuilder
//struct StackBuilder {
//	static public func buildBlock(_ segments: AnyUIView...) -> [AnyUIView] {
//		segments()
//	}
//
//	static public func buildExpression<S: AnyUIView>(_ expression: S) -> AnyUIView {
//		return expression
//	}
//}
@resultBuilder
public struct StackBuilder2 {
	
	//	@inlinable
	 static public func buildBlock(_ components: [UIView]...) -> [UIView] {
		 components.joinedArray()
	 }
	 
 //	@inlinable
	 static public func buildArray(_ components: [[UIView]]) -> [UIView] {
		 components.joinedArray()
	 }
	 
 //	@usableFromInline
	 static public func buildEither(first component: [UIView]) -> [UIView] {
		 component
	 }
	 
 //	@inlinable
	 static public func buildEither(second component: [UIView]) -> [UIView] {
		 component
	 }
	 
 //	@inlinable
	 static public func buildOptional(_ component: [UIView]?) -> [UIView] {
		 component ?? []
	 }
	 
 //	@inlinable
	 static public func buildLimitedAvailability(_ component: [UIView]) -> [UIView] {
		 component
	 }
	 
	 static public func buildExpression(_ expression: UIView) -> [UIView] {
		 return [expression]
	 }
	 
	static public func buildExpression(_ expression: Int) -> [UIView] {
		return [UIView()[height: CGFloat(expression)]]
	}
 //	static public func buildExpression<C: Collection>(_ expression: C) -> [AnyUIView] where C.Element == AnyUIView {
 //		return Array(expression)
 //	}
	 
	 //	static public func buildExpression(_ expression: [C.Item]) -> C.Item {
	 //		C.Items.create(expression)
	 //	}
	 
	 //	static public func buildFinalResult(_ component: [T]) -> <#Result#> {
	 //		<#code#>
	 //	}
	 
 }

public extension ViewBuilder {
	static public func buildExpression(_ expression: UIView) -> some View {
		return expression.swiftUI
	}
	
//	static public func buildExpression<V: View>(_ expression: V) -> V {
//		return expression
//	}
	
	static public func buildExpression(_ expression: Int) -> some View {
		let height = expression
		return Spacer(minLength: CGFloat(height ?? 0))
			.frame(maxWidth: CGFloat(height ?? 0),
						maxHeight: CGFloat(height ?? 0),
						alignment: .center)
	}
}

@resultBuilder
public struct StackBuilder {
	
//	@inlinable
	static public func buildBlock(_ components: [AnyUIView]...) -> [AnyUIView] {
		components.joinedArray()
	}
	
//	@inlinable
	static public func buildArray(_ components: [[AnyUIView]]) -> [AnyUIView] {
		components.joinedArray()
	}
	
//	@usableFromInline
	static public func buildEither(first component: [AnyUIView]) -> [AnyUIView] {
		component
	}
	
//	@inlinable
	static public func buildEither(second component: [AnyUIView]) -> [AnyUIView] {
		component
	}
	
//	@inlinable
	static public func buildOptional(_ component: [AnyUIView]?) -> [AnyUIView] {
		component ?? []
	}
	
//	@inlinable
	static public func buildLimitedAvailability(_ component: [AnyUIView]) -> [AnyUIView] {
		component
	}
	
//	static buildIf(<#T##C?#>)
	
	static public func buildExpression<S: AnyUIView>(_ expression: S) -> [AnyUIView] {
		return [expression]
	}
	
	static public func buildExpression<C: Collection>(_ expression: C) -> [AnyUIView] where C.Element == AnyUIView {
		return Array(expression)
	}
	
	//	static public func buildExpression(_ expression: [C.Item]) -> C.Item {
	//		C.Items.create(expression)
	//	}
	
	//	static public func buildFinalResult(_ component: [T]) -> <#Result#> {
	//		<#code#>
	//	}
	
}

public extension UIFont {
    static public func `default`(_ size: CGFloat) {
        UILabel.appearance().font.withSize(size)
    }
}

public extension UIFont {
    static public func appearance(size: CGFloat) -> UIFont {
        UILabel.appearance().font.withSize(size)
    }
}

public extension UILabel {
    var fontSize: CGFloat {
        get { font.pointSize }
        set { font = font.withSize(newValue) }
    }
}

//public func Label(_ text: String? = "") -> UILabel {
//    UILabel().apply {
//        $0.text = text
//    }
//}

public extension UILabel {

    convenience init(_ text: String? = "") {
        self.init()
        self.text = text
    }
}


public extension UIButton {
//    var title: String {
//        get { title(for: .normal) ?? "" }
//        set { self.setTitle(newValue, for: .normal) }
//    }
//  
//	var titleColor: UIColor {
//		get { titleColor(for: .normal) ?? .clear }
//			set { self.setTitleColor(newValue, for: .normal) }
//	}
//	
//    var image: UIImage? {
//        get { image(for: .normal) }
//        set { self.setImage(newValue, for: .normal) }
//    }
//    
//    var backgroundImage: UIImage? {
//        get { backgroundImage(for: .normal) }
//        set { self.setBackgroundImage(newValue, for: .normal) }
//    }
    
//    var action: (() -> ())? {
//        get { { } }
//        set {
//            let handler = SelectorHandler<UIButton>(referenceHolder: self) { _ in newValue?() }
//            addTarget(handler,
//                      action: #selector(handler.handle(sender:)),
//                      for: .touchUpInside)
//            print("Target")
//
//        }
//    }
    
    public func action(_ action: @escaping () -> Void) -> Self {
        let handler = SelectorHandler<UIButton>(referenceHolder: self) { _ in action() }
        addTarget(handler,
                  action: #selector(handler.handle(sender:)),
                  for: .touchUpInside)
        return self
    }
    
}



public extension UIView {
    var radius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }

    var border: UIBorder {
        get {
            .init(width: layer.borderWidth, color: UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor))
        }
        set {
            self.layer.borderWidth = newValue.width
            self.layer.borderColor = newValue.color.cgColor
            self.layer.masksToBounds = true
        }
    }
}

public struct UIBorder {
    public let width: CGFloat
    public let color: UIColor
    
    public init(width: CGFloat, color: UIColor) {
        self.width = width
        self.color = color
    }
}




open class VC<Input>: UIViewController {
    
    public let input: Input
    
    typealias Input = Input

    public init(_ input: Input) {
        self.input = input
        super.init(nibName: nil, bundle: nil)
    }
    

	required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func viewWillLoad() {
        
    }
    
    override public func loadView() {
        viewWillLoad()
        view = content
//        content
//        content.autoresizingMask = [.flexibleHeight, .flexibleWidth ]
        viewDidLoad()
    }
    
    open var content: UIView {
        __
//        let _ = fatalError()
    }
		
	public func reloadView() {
		view = content

	}
    
    deinit {
        print("Deinited", self)
    }
}

//class StoryBoardVC//<Input>
//: UIViewController {
//
////    let input: Input
////
////    typealias Input = Input
////
////    init(_ input: Input) {
////        self.input = input
////        super.init(nibName: nil, bundle: nil)
////    }
//
//
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    public func viewWillLoad() {
//
//    }
//
//    override public func loadView() {
//        viewWillLoad()
//        view = content
//    }
//
//    var content: UIView {
//        fatalError()
//    }
//
//}
//
//class StoryBoardVCWithInput<Input>
//: UIViewController {
//
//    let input: Input?
//
//    typealias Input = Input
//
//    init(_ input: Input) {
//        self.input = input
//        super.init(nibName: nil, bundle: nil)
//    }
//
//
//    required init?(coder: NSCoder) {
//        self.input = nil
//        super.init(coder: coder)
//    }
//    public func viewWillLoad() {
//
//    }
//
//    override public func loadView() {
//        viewWillLoad()
//        view = content
////        edgesForExtendedLayout = .all
//        viewDidLoad()
//    }
//
//    var content: UIView {
//        fatalError()
//    }
//}

open class ViewWrapper<T>: UIView {
    public let input: T
    
    public init(_ input: T) {
        self.input = input
        super.init(frame: .zero)
        
        willLoad()

        addSubview(content.fill())
        backgroundColor = .clear
        
        didLoad()
    }
    
    open func willLoad() {
        
    }
    
    open func didLoad() {
        
    }
    
	public func reloadView() {
		subviews.first?.removeFromSuperview()
		addSubview(content.fill())
	}
	
    open var content: UIView { UIView() }
    
	required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


@dynamicMemberLookup
public class Class<Input>: NSObject {
    let input: Input
    
    typealias Input = Input

    public init(_ input: Input) {
        self.input = input
        super.init()

        initalize()
    }
    
    subscript <R>(dynamicMember keyPath: KeyPath<Input, R>) -> R {
        input[keyPath: keyPath]
    }
    
    public func initalize() {
        
    }
}



public extension UIButton {
    public subscript(textColor textColor: UIColor? = nil, font font: UIFont? = nil) -> UIButton {
        
        textColor.map { setTitleColor($0, for: .normal) }
        font.map { titleLabel?.font = $0 }
//        setTitle(<#T##title: String?##String?#>, for: .normal)
//        titleLabel.text = self
        return self
    }
}


public extension String {
//    subscript(textColor textColor: UIColor? = nil, fontSize: CGFloat? = nil) -> UILabel {
//        UILabel().apply { label in
//            textColor.map { label.textColor = $0}
//            fontSize.map { label.fontSize = $0 }
//            label.text = self
//        }
//    }
    
    public func label(textColor: UIColor? = nil, font: UIFont? = nil, alignment: NSTextAlignment = .left, lines lines: Int = 1) -> UILabel {
        UILabel().apply { label in
            textColor.map { label.textColor = $0}
            font.map { label.font = $0.withSize($0.pointSize * 1) }
            label.text = self
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = lines
            label.textAlignment = alignment
        }
    }
}

//protocol ViewProtocol {
//    func uiView() -> UIView
//}
//
//extension UIView: ViewProtocol {
//    func uiView() -> UIView {
//        self
//    }
//}

//extension ValueChainingProtocol: ViewProtocol {
//    func uiView() -> UIView {
//        self.apply()
//    }
//}


//extension Publisher where Output == String {
//	subscript(textColor textColor: UIColor? = nil, font font: UIFont? = nil, alignment alignment: NSTextAlignment = .left, lines lines: Int = 1) -> UILabel {
//	
//			UILabel().apply { label in
//					textColor.map { label.textColor = $0}
//					font.map { label.font = $0.withSize($0.pointSize * 1) }
////					label.text = self
//					label.adjustsFontForContentSizeCategory = true
//					label.numberOfLines = lines
//					label.textAlignment = alignment
//			}.chain
//			.text[cb: self.projectedValue]
//	}
//}

public extension AttributableString {
	public func label(textColor: UIColor? = nil, font: UIFont? = nil, alignment: NSTextAlignment = .left, lines lines: Int = 1) -> UILabel {
        UILabel().apply { label in
            textColor.map { label.textColor = $0}
            font.map { label.font = $0 }
            label.attributedText = self.attributedString
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = lines
            label.textAlignment = alignment
        }
    }
}

public extension UILabel {
//    subscript(textColor: UIColor? = nil, fontSize: CGFloat? = nil) -> UILabel {
//        textColor.map { self.textColor = $0}
//        fontSize.map { self.fontSize = $0 }
//        return self
//    }
    subscript(textColor textColor: UIColor? = nil, font font: UIFont? = nil, alignment alignment: NSTextAlignment = .left, lines lines: Int = 1)  -> UILabel {
        self.apply { label in
            textColor.map { label.textColor = $0}
            font.map { label.font = $0.withSize($0.pointSize)  }
            adjustsFontForContentSizeCategory = true
            label.numberOfLines = lines
            label.textAlignment = alignment

        }
    }
}



public extension UIColor {
    public func a(_ alpha: CGFloat) -> UIColor {
        self.withAlphaComponent(alpha)
    }
}


public extension UIEdgeInsets {
    mutating public func bottom(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: value, right: right)
    }
    static public func of(top: CGFloat = 0 , left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        .init(top: top,left: left,bottom: bottom,right: right)
    }
}

public func VScroll(inset: CGFloat = 15, stackConfig: (UIStackView) -> () = {_ in}, _ views: AnyUIView...) -> UIScrollView {
    UIScrollView().apply {
        let vlist = VList(views)
        $0.addSubview(vlist)
        vlist.fillToSuperview(left: inset)
        stackConfig(vlist)
        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
    }
}
public func HScroll(inset: CGFloat = 0, _ views: AnyUIView...) -> UIScrollView {
    UIScrollView().apply {
        let hlist = HList(views)
        $0.addSubview(hlist)
        hlist.fillToSuperview(top: inset)
        
        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
    }
    
}

public extension UIScrollView {
    var pageX: Int {
        get {
            if self.frame.size.width == 0 {
                return 0
            } else {
                return Int(self.contentOffset.x / self.frame.size.width)
            }
        }
        set {
            var offset = contentOffset
            offset.x = CGFloat(newValue) *  self.frame.size.width
            setContentOffset(offset, animated: true)
        }
    }

    var pageY: Int {
        get {
            if self.frame.size.height == 0 {
                return 0
            } else {
                return Int(self.contentOffset.y / self.frame.size.height)
            }
        }
        set {
            var offset = contentOffset
            offset.y = CGFloat(newValue) *  self.frame.size.height
            setContentOffset(offset, animated: true)
        }
    }
}

final public class ContentSizedCollectionView: UICollectionView {
    public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


public func HScrollAutoresized(inset: CGFloat = 0,  _ views: [AnyUIView] )-> ContentSizedScrollView {
    ContentSizedScrollView().apply {
        let hlist = HList(views)
        $0.addSubview(hlist)
        hlist.fillToSuperview()

        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
    }
}

public func HScroll(inset: CGFloat = 0, _ views: [AnyUIView]) -> UIScrollView {
    UIScrollView().apply {
        let hlist = HList(views)
        $0.addSubview(hlist)
        hlist.fillToSuperview(top: inset)

        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
    }
}

//public func VScroll(inset: CGFloat = 15,  @Builder<AnyUIView>_ views: () -> [AnyUIView]) -> UIScrollView {
//    UIScrollView().apply {
//        let vlist = VList(views())
//        $0.addSubview(vlist)
//        vlist.fillToSuperview(left: inset)
//
//        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
//    }
//}
//public func HScroll(inset: CGFloat = 0,  @Builder<AnyUIView>_ views: () -> [AnyUIView]) -> UIScrollView {
//    UIScrollView().apply {
//        let hlist = HList(views())
//        $0.addSubview(hlist)
//        hlist.fillToSuperview(top: inset)
//
//        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
//    }
//}

public func VScrollAutoresized(inset: CGFloat = 15,  @Builder<AnyUIView>_ views: () -> [AnyUIView]) -> ContentSizedScrollView {
    ContentSizedScrollView().apply {
        let vlist = VList(views())
        $0.addSubview(vlist)
        vlist.fillToSuperview(left: inset)
        
        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
    }
}

public func VScrollAutoresized(inset: CGFloat = 15, _ views: AnyUIView...) -> ContentSizedScrollView {
    ContentSizedScrollView().apply {
        let vlist = VList(views)
        $0.addSubview(vlist)
        vlist.fillToSuperview(left: inset)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
    }
}


public func main(_ block: @escaping () -> ()) {
    DispatchQueue.main.async(execute: block)
}



func async(_ queue: DispatchQueue = .global(),
           block: @escaping ()->() )
{
    queue.async(execute: block)
}

func async(_ queue: DispatchQueue = .global(),
           delay: Double,
           block: @escaping ()->() )
{
    queue.asyncAfter(deadline: .now() + delay, execute: block)
}


public extension Collection {
    subscript(_ reducer: (Element, Element) -> Element) -> Element? {
        
        guard var acc: Element = first else { return nil }
        
        for el in self.dropFirst() {
            acc = reducer(acc, el)
        }
        return acc
    }
    
    subscript(_ reducer: (Element, Element) -> Element) -> Element where Element: HasZero {
        
        var acc: Element = first ?? Element.zero
        
        for el in self.dropFirst() {
            acc = reducer(acc, el)
        }
        return acc
    }
    
    subscript<T>(_ mapper: (Element) -> T) -> [T] {
        self.map(mapper)
    }
}

public protocol HasZero {
    static var zero: Self { get }
}

public extension String {
    static var zero: String { "" }
}



public extension String {
//    subscript(action: @escaping ()->()) -> UIButton {
//        UIButton().apply {
//            let handler = SelectorHandler<UIButton>(referenceHolder: $0) { _ in
//                action()
//            }
//            $0.addTarget(handler, action: #selector(handler.handle(sender:)), for: .touchUpInside)
//            $0.setTitle(self, for: .normal)
//        }
//    }
    
    public func button(action: @escaping ()->()) -> UIButton {
        UIButton().apply {
            let handler = SelectorHandler<UIButton>(referenceHolder: $0) { _ in
                action()
            }
            $0.addTarget(handler, action: #selector(handler.handle(sender:)), for: .touchUpInside)
            $0.setTitle(self, for: .normal)
        }
    }

}

extension NSAttributedString: AnyUIView {
    public var getView: UIView {
        UILabel()~
            .attributedText[self]
    }

}

public extension NSAttributedString {
	public func button(action: @escaping ()->()) -> UIButton {
        UIButton().apply {
//            $0.titleLabel?.font = self.
            let handler = SelectorHandler<UIButton>(referenceHolder: $0) { _ in
                action()
            }
            $0.addTarget(handler, action: #selector(handler.handle(sender:)), for: .touchUpInside)
            $0.setAttributedTitle(self, for: .normal)
//            $0.rx.tap ==> action => $0.rx.asDisposeBag
        }
        
    }
}

//extension UIButton {
//    var shrinkOnTap(scale) -> Self
//
//}

public extension UIView {
//	public func button(action: @escaping ()->()) -> UIButton {
//				UIButton().apply {
////            $0.titleLabel?.font = self.
//						let handler = SelectorHandler<UIButton>(referenceHolder: $0) { _ in
//								action()
//						}
//						$0.addTarget(handler, action: #selector(handler.handle(sender:)), for: .touchUpInside)
//						$0.setAttributedTitle(self, for: .normal)
////            $0.rx.tap ==> action => $0.rx.asDisposeBag
//				}
//
//		}
    func button(
        pressedDarkingColor: UIColor = .black.withAlphaComponent(0.1),
        animatePressed: ( (UIView, _ isDown: Bool) -> ())? = nil,
        action: @escaping () -> Void
    ) -> Self {

		let container = self
		let blackTop = UIView()[color: pressedDarkingColor]
//        let tap = container.cb.touchDownGesture { gesture, _ in
//            gesture.isTouchIgnoringEnabled = false
////            gesture.
//        }
//            .longPressGesture() { longpress, _  in
//			longpress.minimumPressDuration = 0.0
////            longpress.
//		}
		
        let animatePressed = animatePressed
                            ??
                        {
                            $1 ? $0.defaultPushAnimation()
                            : $0.defaultPullAnimation()
                        }

        @Rx var isPressed = false

        
		self.addSubviews(blackTop.fill())

        self.addGestureRecognizer(
            HighlightingGestureRecognizer(
                onPressed: { gestureRecognizer in
                    isPressed = true
                },
                onReleased: { _ in
                    action()
                    isPressed = false
                }
            )
        )


        $isPressed
            .removeDuplicates()
            .sink { pressed in
                print("isPressed: ", pressed)

                self.layer.removeAllAnimations()
                UIView.animate(withDuration: 0.1) {
                    blackTop.isShown = pressed
                }
                animatePressed(self, pressed)
            }.store(in: bag(container))

		return self
	}

}






public extension UIImage {
		func imageView(color: UIColor? = nil, width: CGFloat? = nil, height: CGFloat? = nil, rad: CGFloat? = nil, contentMode: UIView.ContentMode? = nil) -> UIImageView {
			UIImageView()[color: color, width: width, height: height, rad: rad].apply {
				$0.contentMode = contentMode ?? .scaleAspectFit
				$0.image = self
			}
    }
}

public extension UIView {
	func defaultPushAnimation() {
		UIView.animate(withDuration: 0.1,
									 delay: 0,
									 options: .curveLinear,
									 animations: { [weak self] in
			self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
		}) {  (done) in
			
		}
	}
	
	func defaultPullAnimation() {

		UIView.animate(withDuration: 0.1,
									 delay: 0,
									 options: .curveLinear,
									 animations: { [weak self] in
			self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
		}) { [weak self] (_) in
		}
	}
	
}

//extension UIImageView {
//    subscript(contentMode contentMode: UIView.ContentMode? = nil) -> UIImageView {
//        self.apply { imageView in
//            contentMode.map { imageView.contentMode = $0 }
//        }
//    }
//}

//class ExtendedButton: UIButton {
//
//    @IBInspectable var margin:CGFloat = 10.0
////    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
////        //increase touch area for control in all directions
////
////        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
////        return area.contains(point)
////
////    }
//    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let verticalInset = CGFloat(margin)
//        let horizontalInset = CGFloat(margin)
//
//        let largerArea = CGRect(
//            x: self.bounds.origin.x - horizontalInset,
//            y: self.bounds.origin.y - verticalInset,
//            width: self.bounds.size.width + horizontalInset*2,
//            height: self.bounds.size.height + verticalInset*2
//        )
//
//        return largerArea.contains(point)
//    }
//
//}


public protocol ArrayInitable {
    associatedtype Item
    static func create(from: [Item]) -> Item
}

//@resultBuilder
//public struct ComposeBuilder<C: ArrayInitable> {
//
//    @inlinable
//    public static public func buildBlock(_ components: C.Item...) -> C.Item {
//        C.create(from: components)
//    }
//
//    @inlinable
//    public static public func buildArray(_ components: [C.Item]) -> C.Item {
//        C.create(from: components)
//    }
//
//    @inlinable
//    public static public func buildEither(first component: C.Item) -> C.Item {
//        component
//    }
//
//    @inlinable
//    public static public func buildEither(second component: C.Item) -> C.Item {
//        component
//    }
//
//    @inlinable
//    public static public func buildOptional(_ component: C.Item?) -> C.Item {
//        component ?? C.create(from: [])
//    }
//
//    @inlinable
//    public static public func buildLimitedAvailability(_ component: C.Item) -> C.Item {
//        component
//    }
//
//    //    static public func buildExpression(_ expression: [C.Item]) -> C.Item {
//    //        C.Items.create(expression)
//    //    }
//
//    //    static public func buildFinalResult(_ component: [T]) -> <#Result#> {
//    //        <#code#>
//    //    }
//
//}

//extension Array: ArrayInitable where Element == AnyUIView {
//    public typealias Item = AnyUIView
//
//    public static public func create(from: [AnyUIView]) -> AnyUIView {
//        <#code#>
//    }
//}
//
//
//import Foundation
//
////public protocol ArrayInitable {
////    associatedtype Item
////    static public func create(from: [Item]) -> Item
////}
//
//@_functionBuilder
//public struct ComposeBuilder<C: ArrayInitable> {
//
//    @inlinable
//    public static public func buildBlock(_ components: C.Item...) -> C.Item {
//        C.create(from: components)
//    }
//
//    @inlinable
//    public static public func buildArray(_ components: [C.Item]) -> C.Item {
//        C.create(from: components)
//    }
//
//    @inlinable
//    public static public func buildEither(first component: C.Item) -> C.Item {
//        component
//    }
//
//    @inlinable
//    public static public func buildEither(second component: C.Item) -> C.Item {
//        component
//    }
//
//    @inlinable
//    public static public func buildOptional(_ component: C.Item?) -> C.Item {
//        component ?? C.create(from: [])
//    }
//
//    @inlinable
//    public static public func buildLimitedAvailability(_ component: C.Item) -> C.Item {
//        component
//    }
//
//    //    static public func buildExpression(_ expression: [C.Item]) -> C.Item {
//    //        C.Items.create(expression)
//    //    }
//
//    //    static public func buildFinalResult(_ component: [T]) -> <#Result#> {
//    //        <#code#>
//    //    }
//
//}


public func Container(subview: (UIView) -> UIView) -> UIView {
    UIView().apply { container in
        container.addSubview(subview(container).fill())
    }
}





public extension Equatable {
    public var with: ValueChaining<Self> { ValueChaining(self) }

}


extension UIView {

}
