//
//  StackView+Rx.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import Foundation
import Combine
import UIKit
import CombineOperators
//import CombineCocoa
import Carbon
import FoundationExtensions
//
//


//extension Equatable: Publisher { }

//public func Label<O: Publisher>(_ observableText: O) -> UILabel where O.Output == String, O.Failure == Never  {
//    UILabel().apply {
//        
//        observableText.map { $0 }.sink($0.cb.text).store(in: $0.cb.asBag)
//    }
//}


//public extension UILabel {
//    convenience init<O: Publisher>(_ observableText: O) where O.Output == String, O.Failure == Never {
//        observableText.map { $0 }.sink(self.cb.text).store(in: self.cb.asBag)
//    }
//}



public extension Publisher {
    func label(textColor: UIColor? = nil,
							font: UIFont? = nil,
							alignment: NSTextAlignment = .left,
							lines: Int = 1)  -> UILabel
    where Output == String, Failure == Never
	{
        UILabel(self)[textColor: textColor, font: font, alignment: alignment, lines: lines]
    }
}


public extension SyncroniusPublisher {
    func label(textColor: UIColor? = nil,
               font: UIFont? = nil,
               alignment: NSTextAlignment = .left,
               lines: Int = 1)  -> UILabel
    where Output == String, Failure == Never
    {

        UILabel(self)[textColor: textColor, font: font, alignment: alignment, lines: lines]
            .apply {
                $0.text = self.wrappedValue
            }
    }
}


//
//
//
//
//
//extension IdentifiableComponent {
//    var cell: CellNode {
//        CellNode(self)
//    }
//}
//
//extension String {
//    subscript(action: @escaping ()->()) -> UIButton {
//        ExtendedButton().apply {
////            $0.titleLabel?.font = self.
//            $0.setTitle(self, for: .normal)
//            $0.rx.tap ==> action => $0.rx.asDisposeBag
//        }
//    }
//}
//
//extension NSAttributedString {
//    subscript(action: @escaping ()->()) -> UIButton {
//        ExtendedButton().apply {
////            $0.titleLabel?.font = self.
//            $0.setAttributedTitle(self, for: .normal)
//            $0.rx.tap ==> action => $0.rx.asDisposeBag
//        }
//    }
//}
//
//extension UIImage {
//
//    subscript(action: @escaping ()->()) -> UIButton {
//        ExtendedButton().apply {
//
//            $0.image = self
//            $0.rx.tap ==> action => $0.rx.asDisposeBag
//        }
//    }
//}
//
//extension UILabel {
//    subscript(action: @escaping ()->()) -> UIButton {
//        ExtendedButton().apply {
//            $0.titleLabel?.font = self.font
//            $0.setTitle(self.text, for: .normal)
//            $0.rx.tap ==> action => $0.rx.asDisposeBag
//        }
//    }
//}
//
//
//let sizeRatio = sqrt(UIScreen.h / 896)
//let sizeRatio2x = UIScreen.h / 896
//
//extension ObservableType where Element: CustomStringConvertible {
//    subscript(textColor: UIColor? = nil, fontSize: CGFloat? = nil) -> UILabel {
//        Label(self.map { $0.description }).apply { label in
//            textColor.map {label.textColor = $0 }
//
//            fontSize.map { label.fontSize = $0  }
//        }
//    }
//}
//
//extension ExpressibleByStringInterpolation where Self: AnyUIView {
//    init(stringInterpolation: StringInterpolationRx) {
//        self = Label(Observable.combineLatest(stringInterpolation.array) { $0[+] ?? "" }) as! Self
//    }
//
//    init(stringLiteral value: String) {
//        self = Label(value) as! Self
//    }
//}
//
//extension ObservablesStringInterpolated {
//    public init(stringInterpolation: StringInterpolationRx) {
//        self = Label(Observable.combineLatest(stringInterpolation.array) { $0[+] ?? "" }) as! Self
//    }
//
//    public init(stringLiteral value: String) {
//        self = Label(value) as! Self
//    }
//
//}
//
//func |<O: ObservableType>(_ lhs: StringInterpolationRx, _ rhs: O) -> StringInterpolationRx where O.Element: CustomStringConvertible  {
//    var left = lhs
//    left.appendInterpolation(rhs)
//    return left
//}
//
//func |(_ lhs: StringInterpolationRx, _ rhs: String) -> StringInterpolationRx {
//    var left = lhs
//    left.appendLiteral(rhs)
//    return left
//}
//
//func |(_ lhs: String, _ rhs: StringInterpolationRx) -> StringInterpolationRx {
//    var r = rhs
//    r.appendLiteral(lhs)
//    return r
//}
//
//func |<O: ObservableType>(_ lhs: O, _ rhs: String) -> StringInterpolationRx where O.Element: CustomStringConvertible {
//    var left = StringInterpolationRx(literalCapacity: 0, interpolationCount: 2)
//    left.appendInterpolation(lhs)
//    left.appendLiteral(rhs)
//    return left
//}
//func |<O: ObservableType>(_ lhs: String, _ rhs: O) -> StringInterpolationRx where O.Element: CustomStringConvertible {
//    var left = StringInterpolationRx(literalCapacity: 0, interpolationCount: 2)
//    left.appendLiteral(lhs)
//    left.appendInterpolation(rhs)
//    return left
//}
//
//
//
//struct StringInterpolationRx: StringInterpolationProtocol {
//    var array: [Observable<String>] = []
//
//    init(literalCapacity: Int, interpolationCount: Int) {
//        self.array.reserveCapacity(interpolationCount)
//    }
//
//    mutating func appendLiteral(_ literal: String) {
//        self.array.append(.just(literal))
//    }
//
//    mutating func appendInterpolation<O: ObservableType>(_ value: O) where O.Element: CustomStringConvertible {
//        self.array.append(value.asObservable().map { $0.description } )
//    }
//    mutating func appendInterpolation(_ value: ObservableChain<String>) {
//        self.array.append(value.asObservable().map { $0 } )
//    }
//    mutating func appendInterpolation(_ value: Observable<String>) {
//        self.array.append(value.asObservable().map { $0 } )
//    }
//}
//
//extension StringInterpolationRx: AnyUIView {
//    var getView: UIView { Label(Observable.combineLatest(self.array) { $0[+] ?? "" }) }
//    subscript(textColor: UIColor? = nil, fontSize: CGFloat? = nil) -> UILabel {
//        Label(Observable.combineLatest(self.array) { $0[+] ?? "" })[textColor, fontSize]
//    }
//
//    subscript(textColor: UIColor? = nil, font: UIFont? = nil) -> UILabel {
//        Label(Observable.combineLatest(self.array) { $0[+] ?? "" })[textColor, font]
//
////        UILabel().apply { label in
////            textColor.map { label.textColor = $0}
////            font.map { label.font = $0.withSize($0.pointSize * 1)
////
////            }
////            label.text = self.l10n
////            label.adjustsFontForContentSizeCategory = true
////
////        }
//    }
//}
//
//extension UILabel: ObservablesStringInterpolated {}
//protocol ObservablesStringInterpolated: ExpressibleByStringInterpolation where StringInterpolation == StringInterpolationRx {
//
//}
//
public extension UIScrollView {
    func withKeyboardInset(_ inset: CGFloat = 0) -> Self {
        CombineKeyboard.instance.visibleHeight.sink {
            self.contentInset.bottom = $0 + inset //; print($0)
            if #available(iOS 11.1, *) {
                self.verticalScrollIndicatorInsets.bottom = $0 - 30
            } else {
                self.scrollIndicatorInsets.bottom = $0
            }
        }.store(in: cb.asBag)

        return self
    }
}


public extension UIView {
    func withKeyboardInsetTranslation(
        _ inset: CGFloat = 0,
        animation: @escaping (@escaping () -> ()) -> () = { $0() }
    ) -> Self {
        CombineKeyboard.instance.visibleHeight.sink { height in
            DispatchQueue.main.async {
                UIView.animate(0.5) {
                    self.transform.offset.y = -(height + inset)
                }
            }
        }.store(in: cb.asBag)

        return self
    }
}

//extension Publisher where Output == [AnyUIView] {
//    var vStack: UIView {
//        UIStackView().apply { stack in
//            self.sink { stack.setV(items: $0) }.store(in: stack.asBag) //=> stack.cb.asBag
//        }
//    }
//}

extension Publisher where Output == AnyUIView {
    var vStack: UIView {
        UIStackView().apply { stack in
					self.sink { stack.setV(items: [$0]) }.store(in: stack.cb.asBag) //=> stack.cb.asBag
        }
    }
}

//
public extension Publisher  {
	func vStack<Seq: Sequence>(selection: ((Seq.Element) -> ())? = nil, separator: @escaping @autoclosure () -> UIView? = nil , row: @escaping (Seq.Element) -> UIView)      -> UIStackView where Output == Seq
    {
        let sep = separator()
        let stack = UIStackView()
        
        self.sink (
            receiveCompletion: {_ in },
            receiveValue: {
                items in
                let list = items.map { el -> UIView in
                    let row = row(el)
                    if let selection = selection { row.onTap { selection(el) } }
                    return row
                }
                
                let items: () -> [AnyUIView] = {
                    if sep != nil {
                        return list.separated { separator() ?? __ }
                    } else {
                        return list
                    }
                }
                stack.setV(items: items())
            }).store(in: stack.cb.asBag)

        return stack
    }
    func hStack<Seq: Sequence>(selection: ((Seq.Element) -> ())? = nil, separator: @escaping @autoclosure () -> UIView? = nil , row: @escaping (Seq.Element) -> UIView)      -> UIStackView where Output == Seq
    {
        let sep = separator()
        let stack = UIStackView()
        
        
        self.sink (
            receiveCompletion: {_ in },
            receiveValue: {
                items in
                let list = items.map { el in row(el).onTap { selection?(el) } }
                
                let items: () -> [AnyUIView] = {
                    if sep != nil {
                        return list.separated { separator() ?? __ }
                    } else {
                        return list
                    }
                }
                stack.setH(items: items())
                
            }).store(in: stack.cb.asBag)

        return stack
    }
}


public typealias TransitionAnimationData = (old: UIView?, new: UIView, container: UIView)

public func SwitchView<Pub: Publisher>(
    _ subj: Pub, 
    animation: @escaping (TransitionAnimationData) -> () = crossfadeDefault(duration: 0.3),
    content: @escaping (Pub.Output) -> AnyUIView
 ) -> UIView {

     let container = UIView().apply {
         $0.backgroundColor = nil
     }

     @Rx var currentView: UIView? = nil
//     __.with.backgroundColor[.yellow]
     subj.sink { currentView = content($0).getView }.store(in: bag(container))

    // $currentView.map { $0 }.vStack
     
     var oldView: UIView? = nil

     $currentView
         .removeDuplicates()
         .skipNil()
//         .withPrevious()
         .sink { [weak container] newView in

             guard let container = container else { return }

             print("switching")

//             let oldView = currentView
//
//             currentView = newView

             animation((oldView, newView, container))

             // container.layoutIfNeeded()
             oldView = newView
         }.store(in: bag(container))

	return container
}



public func rotateTransition() ->  (TransitionAnimationData) -> () {
    { animation in

        animation.new.alpha = 0.0
        animation.container.addSubview(animation.new.fill())

        UIView.transition(with: animation.container,
                          duration: animation.old == nil ? 0 : 0.7,
                          options:[.transitionFlipFromRight])
        {
            animation.new.alpha = 1.0
            animation.old?.alpha = 0.0
        } completion: { _ in
            animation.old?.removeFromSuperview()
        }
    }
}

public func crossfadeDefault(duration: Double = 0.3) ->  (TransitionAnimationData) -> () {
    { animation in

        animation.new.alpha = 0.0
        animation.container.addSubview(animation.new.fill())

        animation.container.layoutIfNeeded()

        UIView.animate(animation.old == nil ? 0 : duration) {
            animation.new.alpha = 1.0
            animation.old?.alpha = 0.0
        } completion: { _ in
            animation.old?.removeFromSuperview()
        }
    }
}

public func crossfadeSoft(duration: Double = 0.5) ->  (TransitionAnimationData) -> () {
    { animation in

        UIView.animate(duration/2) {
            animation.old?.alpha = 0.0
        } completion: { _ in
            animation.old?.removeFromSuperview()
            animation.new.alpha = 0.0
            animation.container.addSubview(animation.new.fill())

            UIView.animate(duration/2) {
                animation.new.alpha = 1.0
            } completion: { _ in
//                animation.completion()
            }
        }
    }
}




func ass<T>(_ obj: Any, type: T.Type) -> T? {
	obj as? T
}

//public func SwitchView<Pub: Publisher>(
//	_ subj: Pub,
//	@ArrayBuilder<MatchEntryAbstract<AnyUIView>> mathcEntries: @escaping () -> [MatchEntryAbstract<AnyUIView>]
//) -> AnyUIView
//{
//	@Rx var currentView: AnyUIView = __
//	let view = $currentView.map { $0 }.vStack
////	var cachedViews = [Int: AnyUIView]
//
//	subj.sink { out in
//		
//		let results = mathcEntries().map { $0.resultIfMatches(value: out) }
//		let index = results.firstIndex(where: { $0 != nil })
//		currentView = results.compactMap { $0 }.first ?? __
//	}.store(in: bag(view))
//
//	return view
//}


//
//func VListRx<O: ObservableType>(_ observableItems: O) -> UIStackView where O.Element == [AnyUIView] {
//    UIStackView().apply { stack in
//        observableItems ==> { stack.setV(items: $0) } => stack.rx.asDisposeBag
//    }
//}

public final class CollectionViewFlowLayoutAdapter: UICollectionViewFlowLayoutAdapter {
 
 public var scrollDelegate: UIScrollViewDelegate?
 
 public func scrollViewDidScroll(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidScroll?(scrollView)
 }
 
 public func scrollViewDidZoom(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidZoom?(scrollView)
 }
 
 public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
 }
 
 public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  scrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
 }
 
 public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
  scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
 }
 
 public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
 }
 
 public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
 }
 
 public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
 }
 
 public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
  scrollDelegate?.viewForZooming?(in: scrollView)
 }
 
 public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
  scrollDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
 }
 
 public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
  scrollDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
 }
 
 public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
  scrollDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
 }
 
 public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
 }
 
 public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
  scrollDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
 }
 
}
