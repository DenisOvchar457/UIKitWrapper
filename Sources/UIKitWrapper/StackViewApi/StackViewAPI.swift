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
import VDKit
import SwiftUI
import CombineOperators

public protocol StackItem {
    var getView: UIView { get }
    
    var height: CGFloat? { get }
    var width: CGFloat? { get }
    
}
public extension StackItem {
    var height: CGFloat? { nil }
    var width: CGFloat? { nil }
}

public extension UIView {
    public func inContainer() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false

        return UIView().apply {
            $0.addSubview(self)
            $0.translatesAutoresizingMaskIntoConstraints = false

        }
    }
    
    public func under(top: CGFloat? = 0,
               left: CGFloat? = 0,
               right: CGFloat? = 0,
               bottom: CGFloat? = 0,
               midY: CGFloat? = nil,
               midX: CGFloat? = nil,
               _ container: StackItem? = nil) -> UIView {
        self.under(top, (left , right), bottom, container)
    }

    public func under(_ top: CGFloat?,
               _ middle: (left: CGFloat?, right: CGFloat?),
               _ bottom: CGFloat?,
               _ container: StackItem? = nil) -> UIView {
        let containerView = container?.getView
        containerView?.isUserInteractionEnabled = true
        
        return (containerView ?? UIView()).apply { outer in
            outer.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            
            fillToSuperview(top: top, left: middle.left, right: middle.right, bottom: bottom)
        }
    }
}

public func V(_ items: StackItem...) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items)
    }
}


//public func VV(_ items: [StackItem])  -> UIStackView {
//    UIStackView().apply {
//        $0.setV(items: items)
//    }
//}

public func V(@StackBuilder items: ()->[StackItem]) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items())
    }
}

public func Z( _ items: StackItem...) -> UIView {
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

public extension UIView {
    public func debugHighlight() -> Self {
        self[border: (1, .yellow)]
    }
}

//public func Z(@Builder<StackItem> items: ()->[StackItem]) -> UIView {
//    let view = UIView()
//    for item in items() {
//        let itemView = item.getView
////        itemView.isUserInteractionEnabled = true
//        view.addSubview(itemView)
//        itemView.fillToSuperview()
//    }
//    return view
//}

public func VList(_ items: [StackItem]) -> UIStackView {
    UIStackView().apply {
        $0.setV(items: items)
    }
}

//public func VList<O: ObservableType>(_ observableItems: O, row: (O.Element) -> StackItem ) -> UIStackView {
//    VListRx(observableItems.map { row($0) })
//}

public func HList(_ items: [StackItem]) -> UIStackView {
    UIStackView().apply {
        $0.setH(items: items)
    }
}

public func H(_ items: StackItem...) -> UIStackView {
    UIStackView().apply {
        
        $0.setH(items: items)
    }
}
public func H(@StackBuilder items: ()->[StackItem]) -> UIStackView {
    UIStackView().apply { $0.setH(items: items()) }
}

//TODO: Группы extension [StackItem]: StackItem

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
    public func darkStyled() -> Self {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        return self
    }
    public func lightStyled() -> Self {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        return self
    }
}

public extension UIStackView {
    func setV(_ items: StackItem...) {
        setV(items: items)
    }
    func setV(items: [StackItem]) {
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
    
    func setH(_ items: StackItem...) {
        setH(items: items)
    }
    func setH(items: [StackItem]) {
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

extension Optional: StackItem where Wrapped: StackItem {
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

public extension Array where Element: StackItem {
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



 extension Int: StackItem {
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

 extension CGFloat: StackItem {
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

 extension Double: StackItem {
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



 extension String: StackItem {

	 public var getView: UIView {
		 UILabel().apply {
			 $0.text = self
		 }
	 }

}

public func space() -> UIView {
    UIView().apply { $0.backgroundColor = .clear }
}


 extension UIView: StackItem {
	 public var getView: UIView { self }
}


public protocol ViewExtension {}
 extension UIView: ViewExtension {}

//TODO: в этом порядке не закрашивается стэквью например )[color: .backgroundBlue].chain.alignment[.center]

public extension ViewExtension where Self: UIView {
    @discardableResult subscript(color color: UIColor? = nil, width width: CGFloat? = nil, height height: CGFloat? = nil, rad radius: CGFloat? = nil, border border: (w: CGFloat, color: UIColor)? = nil) -> Self {
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
    @discardableResult subscript(color color: UIColor? = nil, width width: CGFloat? = nil, height height: CGFloat? = nil, rad radius: CGFloat? = nil, border border: (w: CGFloat, color: UIColor)? = nil) -> UIView {
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
            return self.under()[color: color, width: width, height: height, rad: radius, border: border]
        }

        return self
    }
}

public extension UIStackView {
    var contentV: [StackItem] {
        get { arrangedSubviews }
        set { setV(items: newValue) }
    }
    
    var contentH: [StackItem] {
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

public func |(_ lhs: StackItem, _ rhs: StackItem) -> HorizontalChainer {
    HorizontalChainer(array: [lhs, rhs])
}

public func |(_ lhs: HorizontalChainer, _ rhs: StackItem) -> HorizontalChainer {
    HorizontalChainer(array: lhs.array + rhs)
}

 extension UIImage: StackItem {
	public var getView: UIView {
		UIImageView().apply {
			$0.contentMode = .scaleAspectFit
			$0.image = self
		}
	}
	public var height: CGFloat? { nil }
	public var width: CGFloat? { nil }
}


public struct HorizontalChainer: StackItem {
	public var width: CGFloat? { nil }
    
	public var height: CGFloat? { nil }
	public var lambda: ((UIStackView) -> ())?
	public var getView: UIView { UIStackView().apply { $0.setH(items: array) } }
    
    var array: [StackItem]
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


@_functionBuilder
public struct Vert {

  static public func buildBlock(_ segments: StackItem...) -> UIStackView {
    UIStackView().apply { $0.setV(items: segments) }
  }
    
    static public func buildBlock(_ segments: StackItem) -> UIStackView {
      UIStackView().apply { $0.setV(items: [segments]) }
    }
}
@_functionBuilder
public struct Horiz {
  static public func buildBlock(_ segments: StackItem...) -> UIStackView {
    UIStackView().apply { $0.setH(items: segments) }
  }
}

//@_functionBuilder
//struct ArrayBuilder<T> {
//  static public func buildBlock(_ segments: T...) -> [T] {
//    segments
//  }
//}

@_functionBuilder
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
//	static public func buildBlock(_ segments: StackItem...) -> [StackItem] {
//		segments()
//	}
//
//	static public func buildExpression<S: StackItem>(_ expression: S) -> StackItem {
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
 //	static public func buildExpression<C: Collection>(_ expression: C) -> [StackItem] where C.Element == StackItem {
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
	
	static public func buildExpression<V: View>(_ expression: V) -> V {
		return expression
	}
	
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
	static public func buildBlock(_ components: [StackItem]...) -> [StackItem] {
		components.joinedArray()
	}
	
//	@inlinable
	static public func buildArray(_ components: [[StackItem]]) -> [StackItem] {
		components.joinedArray()
	}
	
//	@usableFromInline
	static public func buildEither(first component: [StackItem]) -> [StackItem] {
		component
	}
	
//	@inlinable
	static public func buildEither(second component: [StackItem]) -> [StackItem] {
		component
	}
	
//	@inlinable
	static public func buildOptional(_ component: [StackItem]?) -> [StackItem] {
		component ?? []
	}
	
//	@inlinable
	static public func buildLimitedAvailability(_ component: [StackItem]) -> [StackItem] {
		component
	}
	
//	static buildIf(<#T##C?#>)
	
	static public func buildExpression<S: StackItem>(_ expression: S) -> [StackItem] {
		return [expression]
	}
	
	static public func buildExpression<C: Collection>(_ expression: C) -> [StackItem] where C.Element == StackItem {
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

public func Label(_ text: String? = "") -> UILabel {
    UILabel().apply {
        $0.text = text
    }
}


public extension UIButton {
    var title: String {
        get { title(for: .normal) ?? "" }
        set { self.setTitle(newValue, for: .normal) }
    }
  
	var titleColor: UIColor {
		get { titleColor(for: .normal) ?? .clear }
			set { self.setTitleColor(newValue, for: .normal) }
	}
	
    var image: UIImage? {
        get { image(for: .normal) }
        set { self.setImage(newValue, for: .normal) }
    }
    
    var backgroundImage: UIImage? {
        get { backgroundImage(for: .normal) }
        set { self.setBackgroundImage(newValue, for: .normal) }
    }
    
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
        viewDidLoad()
    }
    
    open var content: UIView {
        fatalError()
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

        addSubview(content.pin())
        backgroundColor = .clear
        
        didLoad()
    }
    
    open func willLoad() {
        
    }
    
    open func didLoad() {
        
    }
    
	public func reloadView() {
		subviews.first?.removeFromSuperview()
		addSubview(content.pin())
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


public struct StackApiConfig {
    public static var maximumSizeForRescale: CGFloat = 1366
}

public let sizeRatio = sqrt(UIScreen.main.bounds.width / StackApiConfig.maximumSizeForRescale)
//public func size
public let sizeRatio2x = UIScreen.main.bounds.width / StackApiConfig.maximumSizeForRescale

public extension UILabel {
    public func adjustable() -> Self {
        self.minimumScaleFactor = UIScreen.main.bounds.width / 1100//1366
//            0.2//10 / UIFont.labelFontSize
        self.adjustsFontSizeToFitWidth = true
//        self.adju
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

public func VScroll(inset: CGFloat = 15, stackConfig: (UIStackView) -> () = {_ in}, _ views: StackItem...) -> UIScrollView {
    UIScrollView().apply {
        let vlist = VList(views)
        $0.addSubview(vlist)
        vlist.fillToSuperview(left: inset)
        stackConfig(vlist)
        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
    }
}
public func HScroll(inset: CGFloat = 0, _ views: StackItem...) -> UIScrollView {
    UIScrollView().apply {
        let hlist = HList(views)
        $0.addSubview(hlist)
        hlist.fillToSuperview(top: inset)
        
        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
    }
}

//public func VScroll(inset: CGFloat = 15,  @Builder<StackItem>_ views: () -> [StackItem]) -> UIScrollView {
//    UIScrollView().apply {
//        let vlist = VList(views())
//        $0.addSubview(vlist)
//        vlist.fillToSuperview(left: inset)
//
//        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
//    }
//}
//public func HScroll(inset: CGFloat = 0,  @Builder<StackItem>_ views: () -> [StackItem]) -> UIScrollView {
//    UIScrollView().apply {
//        let hlist = HList(views())
//        $0.addSubview(hlist)
//        hlist.fillToSuperview(top: inset)
//
//        $0.heightAnchor.constraint(equalTo: hlist.heightAnchor, constant: inset * 2).isActive = true
//    }
//}

public func VScrollAutoresized(inset: CGFloat = 15,  @Builder<StackItem>_ views: () -> [StackItem]) -> ContentSizedScrollView {
    ContentSizedScrollView().apply {
        let vlist = VList(views())
        $0.addSubview(vlist)
        vlist.fillToSuperview(left: inset)
        
        $0.widthAnchor.constraint(equalTo: vlist.widthAnchor, constant: inset * 2).isActive = true
    }
}

public func VScrollAutoresized(inset: CGFloat = 15, _ views: StackItem...) -> ContentSizedScrollView {
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

public func async(_ block: @escaping () -> ()) {
    DispatchQueue.global().async(execute: block)
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
	func button(backgroundPushed: UIColor? = nil , action: @escaping () -> Void) -> Self {
		var backgroundPushed = backgroundPushed
		var backgroundActive: UIColor? = nil
		
		let container = self
		let blackTop = UIView()[color: .black.withAlphaComponent(0.1)]
		let tap = container.cb.longPressGesture() { longpress, _  in
			longpress.minimumPressDuration = 0.0
		}
		
		self.addSubviews(blackTop.pin())
		
		tap.when(.began).sink { _ in
//			container.backgroundColor = backgroundPushed
			blackTop.isShown = true
			container.showPushAnimation { }
		}.store(in: bag(container))
		
		tap.when(.ended).sink { _ in
			action()
			blackTop.isShown = true

			UIImpactFeedbackGenerator(style: .medium).impactOccurred()
			container.showPullAnimation { }
//			container.backgroundColor = backgroundColor
		}.store(in: bag(container))
		
//		DispatchQueue.main.async {
//			if backgroundPushed == nil {
//				backgroundPushed = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
//				self.backgroundColor.red
//			}
//		}
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
	func showPushAnimation(_ completionBlock: @escaping () -> Void) {
		UIView.animate(withDuration: 0.1,
									 delay: 0,
									 options: .curveLinear,
									 animations: { [weak self] in
			self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
		}) {  (done) in
			
		}
	}
	
	func showPullAnimation(_ completionBlock: @escaping () -> Void) {
		
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

//extension Array: ArrayInitable where Element == StackItem {
//    public typealias Item = StackItem
//
//    public static public func create(from: [StackItem]) -> StackItem {
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
        container.addSubview(subview(container).pin())
    }
}

