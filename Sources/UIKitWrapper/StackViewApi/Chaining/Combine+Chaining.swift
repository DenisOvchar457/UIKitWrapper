//
//  Combine+Chaining.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 16.04.2021.
//

import UIKit
import Combine
//import CombineCocoa
import CombineOperators


@available(iOS 13.0, macOS 10.15, *)
public extension Reactive where Base: UIView {
    
    public var movedToWindow: AnyPublisher<Void, Error> {
        methodInvoked(#selector(UIView.didMoveToWindow))
            .map {[weak base] _ in base?.window != nil }
            .prepend(base.window != nil)
            .filter { $0 }
            .map { _ in }
            .prefix(1)
            .eraseToAnyPublisher()
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension Reactive {
    
    public func binded<O: Publisher, A: Subscriber>(_ kp: KeyPath<Reactive, O>, to observer: A) -> Base where A.Input == O.Output, A.Failure == O.Failure {
        self[keyPath: kp].subscribe(observer)
        return base
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension ChainingProperty where C: ValueChainingProtocol, C.W: AnyObject {
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output == B {
        subscribe(value)
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output == B? {
        subscribe(value.compactMap { $0 })
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output? == B {
        subscribe(value.map { $0 as B })
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output == B {
        subscribe(value)
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output == B? {
        subscribe(value.compactMap { $0 })
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output? == B {
        subscribe(value.map { $0 as B })
        return chaining.apply()
    }
    
    private func subscribe<P: Publisher>(_ value: P) where P.Output == B {
        let result = chaining.wrappedValue
        let setter = (getter as? ReferenceWritableKeyPath<C.W, B>)?.set
        value => {[weak result] in
            guard let it = result else { return }
            _ = setter?(it, $0)
        }
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension ChainingProperty where C: ValueChainingProtocol, C.W: AnyObject, B: Equatable {
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B {
        if skipEqual {
            subscribe(value.removeDuplicates())
        } else {
            subscribe(value)
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B? {
        if skipEqual {
            subscribe(value.removeDuplicates().compactMap { $0 })
        } else {
            subscribe(value.compactMap { $0 })
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output? == B {
        if skipEqual {
            subscribe(value.removeDuplicates().map { $0 as B })
        } else {
            subscribe(value.map { $0 as B })
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output == B {
        if skipEqual {
            subscribe(value.removeDuplicates())
        } else {
            subscribe(value)
        }
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output == B? {
        if skipEqual {
            subscribe(value.removeDuplicates().compactMap { $0 })
        } else {
            subscribe(value.compactMap { $0 })
        }
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output? == B {
        if skipEqual {
            subscribe(value.removeDuplicates().map { $0 as B })
        } else {
            subscribe(value.map { $0 as B })
        }
        return chaining.apply()
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension ChainingProperty where C: ValueChainingProtocol, B: Subscriber {
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output == B.Input, O.Failure == B.Failure {
        subscribe(value)
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output == B.Input?, O.Failure == B.Failure {
        subscribe(value.compactMap { $0 })
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C where O.Output? == B.Input, O.Failure == B.Failure {
        subscribe(value.map { $0 as B.Input })
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output == B.Input, O.Failure == B.Failure {
        subscribe(value)
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output == B.Input?, O.Failure == B.Failure {
        subscribe(value.compactMap { $0 })
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O) -> C.W where O.Output? == B.Input, O.Failure == B.Failure {
        subscribe(value.map { $0 as B.Input })
        return chaining.apply()
    }
    
    private func subscribe<P: Publisher>(_ value: P) where P.Output == B.Input, P.Failure == B.Failure {
        value => getter.get(chaining.wrappedValue)
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension ChainingProperty where C: ValueChainingProtocol, B: Subscriber, B.Input: Equatable {
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B.Input, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates())
        } else {
            subscribe(value)
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output == B.Input?, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates().compactMap { $0 })
        } else {
            subscribe(value.compactMap { $0 })
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C where O.Output? == B.Input, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates().map { $0 as B.Input })
        } else {
            subscribe(value.map { $0 as B.Input })
        }
        return chaining
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output == B.Input, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates())
        } else {
            subscribe(value)
        }
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output == B.Input?, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates().compactMap { $0 })
        } else {
            subscribe(value.compactMap { $0 })
        }
        return chaining.apply()
    }
    
    public subscript<O: Publisher>(cb value: O, skipEqual: Bool = true) -> C.W where O.Output? == B.Input, O.Failure == B.Failure {
        if skipEqual {
            subscribe(value.removeDuplicates().map { $0 as B.Input })
        } else {
            subscribe(value.map { $0 as B.Input })
        }
        return chaining.apply()
    }
    
}

@available(iOS 13.0, macOS 10.15, *)
public extension ChainingProperty where C: ValueChainingProtocol, B: Publisher {
    
    public subscript<O: Subscriber>(_ observer: O) -> C where O.Input == B.Output, O.Failure == B.Failure {
        subscribe(observer)
    }
    
    public subscript<O: Subscriber>(_ observer: O) -> C where O.Input == B.Output?, O.Failure == B.Failure {
        subscribe(observer.mapSubscriber { $0 })
    }
    
    public subscript<O: Subscriber>(_ observer: O) -> C where O.Input? == B.Output, O.Failure == B.Failure {
        subscribe(observer.ignoreNil())
    }
    
    
    public subscript<O: Subscriber>(_ observer: O) -> C.W where O.Input == B.Output, O.Failure == B.Failure {
        subscribe(observer).apply()
    }
    
    public subscript<O: Subscriber>(_ observer: O) -> C.W where O.Input == B.Output?, O.Failure == B.Failure {
        subscribe(observer.mapSubscriber { $0 }).apply()
    }
    
    public subscript<O: Subscriber>(_ observer: O) -> C.W where O.Input? == B.Output, O.Failure == B.Failure {
        subscribe(observer.ignoreNil()).apply()
    }
    
    
    
    
    private func subscribe<O: Subscriber>(_ value: O) -> C where O.Input == B.Output, O.Failure == B.Failure {
        let result = chaining.wrappedValue
        getter.get(result).subscribe(value)
        return chaining
    }

    public func on(_ action: @escaping (B.Output) -> Void) -> C {
        subscribe(
            AnySubscriber(
                receiveSubscription: {
                    $0.request(.unlimited)
                },
                receiveValue: {
                    action($0)
                    return .unlimited
                },
                receiveCompletion: nil
            )
        )
    }
}
//extension TwoWayBindable {
//}
//
//protocol TwoWayBindable: class, ReactiveCompatible { }
//extension NSObject: TwoWayBindable {
//
//}
//
//extension TwoWayBindable where Self: NSObject {
//    func twoWay<Value: Equatable>(_ property: ReferenceWritableKeyPath<Self, Value>, rx: Rx<Value>) -> Self {
//        rx.projectedValue.sink {
//            self[keyPath: property] = $0
//        }.store(in: self.cb.asBag)
//
//        self.publisher(for: property)
//            .removeDuplicates()
//            .sink { rx.wrappedValue = $0 }
//            .store(in: self.cb.asBag)
//        return self
//    }
//
//}

public extension ReactiveCompatible where Self: NSObject {
    func twoWayKVO<Value: Equatable>(_ property: ReferenceWritableKeyPath<Self, Value>, rx: CurrentValueSubject<Value, Never>) -> Self {
        rx.removeDuplicates()
            .sink {
                self[keyPath: property] = $0
            }.store(in: self.cb.asBag)
        
        self.publisher(for: property)
            .removeDuplicates()
            .sink { rx.value = $0 }
            .store(in: self.cb.asBag)
        return self
    }
    
    func twoWay<Value: Equatable>(_ property: KeyPath<Self, ControlProperty<Value>>, binding: ValueBinding<Value>) -> Self {
        binding.removeDuplicates()
            .sink {
                self[keyPath: property].receive($0)
            }.store(in: self.cb.asBag)
        
        self[keyPath: property]
            .removeDuplicates()
            .sink { binding.receive($0) }
            .store(in: self.cb.asBag)
        
        return self
    }
    
    func twoWay<Value: Equatable>(_ property: KeyPath<Self, ControlProperty<Value?>>, binding: ValueBinding<Value> , default: Value) -> Self {
        binding.removeDuplicates()
            .sink {
                self[keyPath: property].receive($0)
            }.store(in: self.cb.asBag)
        
        self[keyPath: property]
            .removeDuplicates()
            .sink { binding.receive($0 ?? `default`) }
            .store(in: self.cb.asBag)
        
        return self
    }
}

public func twoWay<Value: Equatable>(subject1: CurrentValueSubject<Value, Never>, subject2: CurrentValueSubject<Value, Never>) -> [AnyCancellable]{
    [subject1.removeDuplicates().sink(subject2),//.store(in: )
    
    subject2.removeDuplicates().sink(subject1)]//.store(in: self.cb.asBag)
}

public func twoWay<Value: Equatable, Left: Publisher & Subscriber, Right: Publisher & Subscriber>(subject1: Left, subject2: Right) -> [AnyCancellable]
where Value == Left.Input,
      Value == Left.Output,
      Value == Right.Output,
      Value == Right.Input,
      Left.Failure == Right.Failure
{
    [subject1.removeDuplicates().sink(subject2),//.store(in: )
    
    subject2.removeDuplicates().sink(subject1)]//.store(in: self.cb.asBag)
}

//func twoWay<Value: Equatable>(subject1: CurrentValueSubject<Value, Never>, subject2: CurrentValueSubject<Value?, Never>, default: Value) -> [AnyCancellable]{
//    [subject1.removeDuplicates().sink {
//        subject2.value = $0
//    },
//
//    subject2.removeDuplicates().sink {
//        subject1.value = $0 ?? `default`
//    }]
//
//}

//extension Binding {
//
//
//}


//extension Binding {
//
//}

//extension TwoWayBindable where Self: NSObject {
//    func twoWayKVO<Value: Equatable>(_ property: ReferenceWritableKeyPath<Self, Value>, rx: CurrentValueSubject<Value, Never>) -> Self {
//        rx.removeDuplicates()
//            .sink {
//                self[keyPath: property] = $0
//            }.store(in: self.cb.asBag)
//
//        self.publisher(for: property)
//            .removeDuplicates()
//            .sink { rx.value = $0 }
//            .store(in: self.cb.asBag)
//        return self
//    }
//
//    func twoWay<Value: Equatable>(_ property: KeyPath<Self, ControlProperty<Value>>, rx: CurrentValueSubject<Value, Never>) -> Self {
//        rx.removeDuplicates()
//            .sink {
//                self[keyPath: property].receive($0)
//            }.store(in: self.cb.asBag)
//
//        self[keyPath: property]
//            .removeDuplicates()
//            .sink { rx.value = $0 }
//            .store(in: self.cb.asBag)
////        self.publisher(for: property)
////            .removeDuplicates()
////            .sink { rx.value = $0 }
////            .store(in: self.cb.asBag)
////
////
////        UISwitch().cb.is
//
//        return self
//    }
//
//}
