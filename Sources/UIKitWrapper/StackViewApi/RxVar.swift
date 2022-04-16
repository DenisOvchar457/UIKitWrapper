//
//  RxVar.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 16.04.2021.
//

import Combine
import CombineOperators
import SwiftUI
//extension PublishSubject: Decodable where PublishSubject.Element: Decodable {
//    convenience public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let value = try container.decode(Element.self)
//        self.init()
//        self.onNext(value)
//    }
//}


//@dynamicMemberLookup
//@propertyWrapper
//class Rx<Value> {
//    let get: () -> Value
//    let set: (Value) -> Void
//
//    var projectedValue: Rx<Value> { self }
//
//    let subject: CurrentValueSubject<Value, Never>
//
//    init<Root>(_ object: Root, _ path: ReferenceWritableKeyPath<Root, Value>) {
//
//        self.get = { object[keyPath: path] }
//        let subject = CurrentValueSubject<Value, Never>(value: get())
//        self.subject = subject
//        self.set = { object[keyPath: path] = $0; subject.accept($0) }
//    }
//
//    init(_ subject: BehaviorRelay<Value>) {
//        self.set = subject.accept
//        self.get = { subject.value }
//        self.subject = BehaviorRelay<Value>(value: subject.value)
//    }
//
//    init(wrappedValue: Value) {
//        let subject = BehaviorRelay<Value>(value: wrappedValue)
//        self.subject = subject
//        self.set = subject.accept
//        self.get = { subject.value }
//    }
//
//    public var wrappedValue: Value {
//        get { get() }
//        set { set(newValue) }
//    }
//
////    subscript <R>(dynamicMember keyPath: KeyPath<Element, R>) -> Observable<R> {
////        self.map { $0[keyPath: keyPath] }
////    }
//
////    subscript <R>(dynamicMember keyPath: KeyPath<Element, R>) -> ObservableChain<R> {
////        ObservableChain<R>(observable: self.map { $0[keyPath: keyPath] })
////    }
//}

public typealias Rx = ValueSubject
//@dynamicMemberLookup
//@propertyWrapper
//class Rx<Value> {
//    let get: () -> Value
//    let set: (Value) -> Void
//
//    var projectedValue: Rx<Value> { self }
//
//    let subject: CurrentValueSubject<Value, Never>
//
//    init<Root>(_ object: Root, _ path: ReferenceWritableKeyPath<Root, Value>) {
//
//        self.get = { object[keyPath: path] }
//        let subject = CurrentValueSubject<Value, Never>(value: get())
//        self.subject = subject
//        self.set = { object[keyPath: path] = $0; subject.accept($0) }
//    }
//
//    init(_ subject: BehaviorRelay<Value>) {
//        self.set = subject.accept
//        self.get = { subject.value }
//        self.subject = BehaviorRelay<Value>(value: subject.value)
//    }
//
//    init(wrappedValue: Value) {
//        let subject = BehaviorRelay<Value>(value: wrappedValue)
//        self.subject = subject
//        self.set = subject.accept
//        self.get = { subject.value }
//    }
//
//    public var wrappedValue: Value {
//        get { get() }
//        set { set(newValue) }
//    }
//
////    subscript <R>(dynamicMember keyPath: KeyPath<Element, R>) -> Observable<R> {
////        self.map { $0[keyPath: keyPath] }
////    }
//
////    subscript <R>(dynamicMember keyPath: KeyPath<Element, R>) -> ObservableChain<R> {
////        ObservableChain<R>(observable: self.map { $0[keyPath: keyPath] })
////    }
//}



//
//
//extension Rx where Value: OptionalProtocol {
//    subscript <R>(dynamicMember keyPath: KeyPath<Value.Wrapped, R>) -> Observable<R?> {
//        self.map { $0.wrapped?[keyPath: keyPath] }
//    }
//}
//
//extension Rx: ObservableType {
//    func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element
//    { subject//.map(printed)
//        .subscribe(observer) }
//
//    typealias Element = Value
//}
//
//extension Rx: ObserverType {
//    func on(_ event: Event<Value>) {
//        switch event {
//        case let.next(value): wrappedValue = value
//        case .error: break
//        case .completed: break
//        }
//    }
//}
//
//extension ObservableType {
//
//}
//
//
//public extension Sequence {
//    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
//        return map { $0[keyPath: keyPath] }
//    }
//}
//
//public protocol OptionalProtocol {
//    associatedtype Wrapped
//    var wrapped: Wrapped? { get }
//}
//extension Optional: OptionalProtocol {
//    public var wrapped: Wrapped? {
//        switch self {
//        case .none: return nil
//        case .some(let wrapped): return wrapped
//        }
//    }
//}
//
//extension Optional where Wrapped == String {
//    var nilOrEmpty: Bool {
//        self == nil || self == ""
//    }
//}
//
//extension ObservableType where Element: OptionalProtocol {
//    subscript <R>(_ path: KeyPath<Element.Wrapped, R>) -> Observable<R?> {
//        self.map { $0.wrapped?[keyPath: path] }
//    }
//}
//
//public extension ObservableType {
//    subscript <R>(_ path: KeyPath<Element, R>) -> Observable<R> {
//        self.map { $0[keyPath: path] }
//    }
//}
//
//
//public func &<T1: ObservableConvertibleType,
//               T2: ObservableConvertibleType>(_ lhs: T1, rhs: T2)
//-> (T1,T2)
//{ (lhs, rhs) }
//
//public func &<T1: ObservableConvertibleType,
//               T2: ObservableConvertibleType>(_ lhs: T1, rhs: T2)
//-> Observable<(T1.Element,T2.Element)>
//{ Observable.combineLatest(lhs.asObservable(), rhs.asObservable()) }
//
//
//public func &<T1: ObservableConvertibleType,
//               T2: ObservableConvertibleType,
//               T3: ObservableConvertibleType>(_ lhs: (T1,T2),
//                                                rhs: T3)
//-> (T1,T2,T3)
//{ (lhs.0, lhs.1, rhs) }
//
//public func &<T1: ObservableConvertibleType,
//               T2: ObservableConvertibleType,
//               T3: ObservableConvertibleType>(_ lhs: (T1,T2),
//                                                rhs: T3)
//-> Observable<(T1.Element,T2.Element, T3.Element)>
//{ Observable.combineLatest(lhs.0.asObservable(), lhs.1.asObservable(), rhs.asObservable()) }
//
//
//public prefix func !<O: ObservableType>(_ r: O) -> Observable<O.Element> where O.Element == Bool {
//    r.map { !$0 }
//}
//
//
//
//public func ??<T: ObservableType>(_ lhs: T, _ rhs: @escaping @autoclosure () -> T.Element.Wrapped) -> Observable<T.Element.Wrapped>  where T.Element: OptionalProtocol
//{
//    return lhs.map { $0.wrapped ?? rhs() }
//}
//
//extension BehaviorRelay {
//    var val: Element {
//        get { value }
//        set { accept(newValue)}
//    }
//}
//
//
//extension ReactiveCompatible where Self: NSObject {
//    func rX(@Builder<Disposable> block: (Self) -> ([Disposable])) -> Self {
//        rx.asDisposeBag.insert(block(self))
//        return self
//    }
//}
//
//extension Observable: StackItem where Element: StackItem {
//    var getView: UIView {
//
//        UIStackView().apply { stack in
//            self ==> { new in
//
//                stack.transition(.top) {
//                    stack.setV(self.getView)
//                }
//            } => stack.rx.asDisposeBag
//
//        }
//    }
//}
//
//
//
//func printed<T>(t: T) -> T {
//    print("printed:" ,t)
//    return t
//}
//
//extension Reactive where Base: UIView {
//    public var isShown: Binder<Bool> {
//        return Binder(self.base) { view, shown in
//            view.isShown = shown
//        }
//    }
//}
//
//extension Reactive where Base: AnyObject {
//
//    public var asDisposeBag: DisposeBag {
//        if let dispose = objc_getAssociatedObject(base, &disposeBagKey) as? DisposeBag { return dispose }
//        let dispose = DisposeBag()
//        objc_setAssociatedObject(base, &disposeBagKey, dispose, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        return dispose
//    }
//}
//
//fileprivate var disposeBagKey = "ReactiveDisposeBagKey"
//
//extension ObservableType {
//    public var result: Observable<Result<Element, Error>> {
//      Observable.create { observer in
//       self.subscribe { event in
//        switch event {
//        case .next(let element):
//         observer.onNext(.success(element))
//        case .error(let error):
//         observer.onNext(.failure(error))
//        case .completed:
//         observer.onCompleted()
//        }
//       }
//      }
//     }
//
//
//}
//extension Single {
//
//    func on(success: ((Element) -> ())? = nil,
//            error: ((Error) -> ())? = nil,
//            completed: (() -> ())? = nil) where Trait == SingleTrait
//    {
//        self.subscribe (
//            onSuccess: {
//                success?($0)
//                completed?()
//            },
//            onError: {
//                error?($0)
//                completed?()
//            }
//        )
//    }
//
//}



//typealias RX = Builder<Disposable>
//
//typealias Res<T> = Swift.Result<T, Error>
//extension Res {
//    init(_ t: Success) {
//        self = .success(t)
//    }
//    init(_ er: Failure) {
//        self = .failure(er)
//    }
//}
//
//
//extension ObservableType {
//    func forEach(_ block: @escaping (Element) -> ()) -> Observable<Element> {
//        self.do(onNext: block)
//    }
//    func forEach(_ block: @escaping () -> ()) -> Observable<Element> {
//        self.do(onNext: { _ in block() })
//    }
//}


