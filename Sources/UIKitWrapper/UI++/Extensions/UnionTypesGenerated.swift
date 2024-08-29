//
//  UnionTypesGenerated.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 08.06.2021.
//

import Foundation

//public struct U2<A0,A1> {
//
//	let value: Any
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>,
//								 _ a1: MatchEntry<A1,T>
//	) -> T {
//		value(A0.self).map( a0.block) ??
//								 value(A1.self).map( a1.block)!
//	}
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>? = nil,
//								 _ a1: MatchEntry<A1,T>? = nil
//			,el: (U2) -> T
//	) -> T {
//
//		if let a0 = a0, let value = value(A0.self) {
//			return a0.block(value)
//		}
//		if let a1 = a1, let value = value(A1.self) {
//			return a1.block(value)
//		}
//			return el(self)
//	}
//
//	var a0: A0? { value(A0.self) }
//		
//	init(_ value: A0) {
//		self.value = value
//	}
//	
//	func value(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	
//	subscript(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	var a1: A1? { value(A1.self) }
//		
//	init(_ value: A1) {
//		self.value = value
//	}
//	
//	func value(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//	
//	subscript(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//
//}
//
//extension U2: Equatable where A0: Equatable,A1: Equatable  {
//
//	public static func == (lhs: U2<A0,A1>, rhs: U2<A0,A1>)
// -> Bool
//	{
//		return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1
//	}
//}
//
//extension U2: Hashable where A0: Hashable,A1: Hashable {
//	public func hash( into: inout Hasher) {
//		into.combine(a0?.hashValue ?? a1?.hashValue ?? 0)
//	}
//}
//public struct U3<A0,A1,A2> {
//
//	let value: Any
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>,
//								 _ a1: MatchEntry<A1,T>,
//								 _ a2: MatchEntry<A2,T>
//	) -> T {
//		value(A0.self).map( a0.block) ??
//								 value(A1.self).map( a1.block) ??
//								 value(A2.self).map( a2.block)!
//	}
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>? = nil,
//								 _ a1: MatchEntry<A1,T>? = nil,
//								 _ a2: MatchEntry<A2,T>? = nil
//			,el: (U3) -> T
//	) -> T {
//
//		if let a0 = a0, let value = value(A0.self) {
//			return a0.block(value)
//		}
//		if let a1 = a1, let value = value(A1.self) {
//			return a1.block(value)
//		}
//		if let a2 = a2, let value = value(A2.self) {
//			return a2.block(value)
//		}
//			return el(self)
//	}
//
//	var a0: A0? { value(A0.self) }
//		
//	init(_ value: A0) {
//		self.value = value
//	}
//	
//	func value(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	
//	subscript(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	var a1: A1? { value(A1.self) }
//		
//	init(_ value: A1) {
//		self.value = value
//	}
//	
//	func value(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//	
//	subscript(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//	var a2: A2? { value(A2.self) }
//		
//	init(_ value: A2) {
//		self.value = value
//	}
//	
//	func value(_ type: A2.Type) -> A2? {
//		return value as? A2
//	}
//	
//	subscript(_ type: A2.Type) -> A2? {
//		return value as? A2
//	}
//
//}
//
//public extension U3: Equatable where A0: Equatable,A1: Equatable,A2: Equatable  {
//
//	static func == (lhs: U3<A0,A1,A2>, rhs: U3<A0,A1,A2>)
// -> Bool
//	{
//		return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1 && lhs.a2 == rhs.a2
//	}
//
//}
//
//public extension U3: Hashable where A0: Hashable,A1: Hashable,A2: Hashable {
//	public func hash( into: inout Hasher) {
//		into.combine(a0?.hashValue ?? a1?.hashValue ?? a2?.hashValue ?? 0)
//	}
//}
//public struct U4<A0,A1,A2,A3> {
//
//	let value: Any
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>,
//								 _ a1: MatchEntry<A1,T>,
//								 _ a2: MatchEntry<A2,T>,
//								 _ a3: MatchEntry<A3,T>
//	) -> T {
//		value(A0.self).map( a0.block) ??
//								 value(A1.self).map( a1.block) ??
//								 value(A2.self).map( a2.block) ??
//								 value(A3.self).map( a3.block)!
//	}
//
//	@discardableResult func match<T>(
//		_ a0: MatchEntry<A0,T>? = nil,
//								 _ a1: MatchEntry<A1,T>? = nil,
//								 _ a2: MatchEntry<A2,T>? = nil,
//								 _ a3: MatchEntry<A3,T>? = nil
//			,el: (U4) -> T
//	) -> T {
//
//		if let a0 = a0, let value = value(A0.self) {
//			return a0.block(value)
//		}
//		if let a1 = a1, let value = value(A1.self) {
//			return a1.block(value)
//		}
//		if let a2 = a2, let value = value(A2.self) {
//			return a2.block(value)
//		}
//		if let a3 = a3, let value = value(A3.self) {
//			return a3.block(value)
//		}
//			return el(self)
//	}
//
//	var a0: A0? { value(A0.self) }
//		
//	init(_ value: A0) {
//		self.value = value
//	}
//	
//	func value(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	
//	subscript(_ type: A0.Type) -> A0? {
//		return value as? A0
//	}
//	var a1: A1? { value(A1.self) }
//		
//	init(_ value: A1) {
//		self.value = value
//	}
//	
//	func value(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//	
//	subscript(_ type: A1.Type) -> A1? {
//		return value as? A1
//	}
//	var a2: A2? { value(A2.self) }
//		
//	init(_ value: A2) {
//		self.value = value
//	}
//	
//	func value(_ type: A2.Type) -> A2? {
//		return value as? A2
//	}
//	
//	subscript(_ type: A2.Type) -> A2? {
//		return value as? A2
//	}
//	var a3: A3? { value(A3.self) }
//		
//	init(_ value: A3) {
//		self.value = value
//	}
//	
//	func value(_ type: A3.Type) -> A3? {
//		return value as? A3
//	}
//	
//	subscript(_ type: A3.Type) -> A3? {
//		return value as? A3
//	}
//
//}
//
//public extension U4: Equatable where A0: Equatable,A1: Equatable,A2: Equatable,A3: Equatable  {
//
//	static func == (lhs: U4<A0,A1,A2,A3>, rhs: U4<A0,A1,A2,A3>)
// -> Bool
//	{
//		return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1 && lhs.a2 == rhs.a2 && lhs.a3 == rhs.a3
//	}
//}
//
//public extension U4: Hashable where A0: Hashable,A1: Hashable,A2: Hashable,A3: Hashable {
//	func hash( into: inout Hasher) {
//		into.combine(a0?.hashValue ?? a1?.hashValue ?? a2?.hashValue ?? a3?.hashValue ?? 0)
//	}
//}
