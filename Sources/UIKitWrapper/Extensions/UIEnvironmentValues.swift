//
//  File.swift
//  
//
//  Created by Данил Войдилов on 31.12.2021.
//

//import Foundation
//import UIKit
//
//public struct UIEnvironmentValues {
//	
//	private var values: [AnyKeyPath: Any] = [:]
//	var link: (() -> UIEnvironmentValues?)?
//	
//	public init() {}
//	
//	public subscript<T>(_ keyPath: WritableKeyPath<UIEnvironmentValues, T>) -> T? {
//		get {
//			self[key: keyPath]
//		}
//		set {
//			self[key: keyPath] = newValue
//		}
//	}
//	
////	public subscript<T>(_ keyPath: KeyPath<UI, UIEnvironmentValue<T>>) -> T {
////		get {
////			self[key: keyPath] ?? EmptyUI()[keyPath: keyPath].defaultValue
////		}
////		set {
////			self[key: keyPath] = newValue
////		}
////	}
//	
//	private subscript<T>(key keyPath: AnyKeyPath) -> T? {
//		get {
//			if let any = values[keyPath] ?? link?()?[key: keyPath] {
//				return any as? T
//			}
//			return nil
//		}
//		set {
//			guard let newValue = newValue else { return }
//			values[keyPath] = newValue
//		}
//	}
//	
//	public mutating func merge(with parent: UIEnvironmentValues) {
//		values.merge(parent.values) { it, _ in
//			it
//		}
//	}
//}
//
//extension UIResponder {
//	
//	public var environments: UIEnvironmentValues {
//		get {
//			var result = associated.environments
//			if let parent = next {
//				result.link = {[weak parent] in parent?.environments }
//			}
//			return result
//		}
//		set {
//			var result = newValue
//			result.link = nil
//			associated.environments = result
//		}
//	}
//}
//
//private extension AssociatedValues {
//	var environments: UIEnvironmentValues {
//		get { self[\.environments] ?? .init() }
//		set { self[\.environments] = newValue }
//	}
//}
