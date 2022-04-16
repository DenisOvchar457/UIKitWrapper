//
//  Plist.swift
//  Compass
//
//  Created by  Denis Ovchar new on 17.12.2020.
//  Copyright © 2020 work. All rights reserved.
//

import Foundation
import VDKit
import Combine
import CombineOperators
//import CombineCocoa
import VDCodable

public protocol NameSpaceReadable {
    static var nameSpace: String { get }
}
public extension NameSpaceReadable {
    static var nameSpace: String {
        let fullTypeName = String(reflecting: type(of: Self.self))
        return fullTypeName
    }
}

public class PlistManager {
    static func set< T: Codable>(_ value: T, for key: String) {
        if  let dictionary = try? VDJSONEncoder().encode(value) {
            UserDefaults.standard.set(dictionary, forKey: key)
        } else {
            UserDefaults.standard.set( value as AnyObject, forKey: key)
        }
    }
    
    static func value< T: Codable>(for key: String) -> T? {
        let value = UserDefaults.standard.value(forKey: key)

        if let data = value as? Data {
            return try? VDJSONDecoder().decode(T.self, from: data)
        } else {
            return value as? T
        }
    }
    
    static func clearAll() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}


@propertyWrapper
public struct Cached <T: Codable> {
	
	let key: String
	let deflt: T
	
	public var projectedValue: CurrentValueSubject<T, Never> {
		cachedInstance.subject
	}
	
	public var wrappedValue: T {
		get {
			cachedInstance.subject.value
		}
		set {
			cachedInstance.subject.value = newValue
		}
	}
	
	public init(wrappedValue: T, _ key: String) {
		self.key = key
		self.deflt = wrappedValue

	}
	
	public init<V>(_ key: String) where V? == T {
		self.key = key
		self.deflt = nil
	}
	
	var cachedInstance: CachedInstance<T> {
		getCachedInstance(key: key, deflt: deflt)
	}
}

class CachedInstance<T: Codable> {
	
	let key: String

	public let subject: CurrentValueSubject<T, Never>
	
	private var didInit = false
	
	init(key: String, deflt: T) {
		self.key = key
		
		subject = .init(PlistManager.value(for: key) ?? deflt)
		
		subject
			.receive(on: .main)
			.sink {
			print("SINK")
			if self.didInit {
				print("SET", $0)
				PlistManager.set($0, for: key)
			} else {
				print("DIDINIt")
				self.didInit = true
			}
		}.store(in: bag(self))
	}
}

func getCachedInstance<T>(key: String, deflt: T) -> CachedInstance<T> {
	if let instance = cachedInstances[key] as? CachedInstance<T> {
		return instance
	} else {
		let new = CachedInstance<T>(key: key, deflt: deflt)
		cachedInstances[key] = new
		return new
	}
}





//@propertyWrapper
//struct CachedOpt <T: Codable> {
//
//	let key: String
//
//	public var projectedValue: CurrentValueSubject<T?, Never> {
//		cachedInstance.subject
//	}
//
//	var wrappedValue: T? {
//		get {
//			cachedInstance.subject.value
//		}
//		set {
//			cachedInstance.subject.value = newValue
//		}
//	}
//
//	init(_ key: String) {
//		self.key = key
//	}
//
//	var cachedInstance: CachedInstanceOpt<T> {
//		getCachedInstanceOpt(key: key)
//	}
//}
//
//class CachedInstanceOpt<T: Codable> {
//	let key: String
//
//	public let subject: CurrentValueSubject<T?, Never>
//
//	private var didInit = false
//
//	init(key: String) {
//		self.key = key
//		subject = .init(PlistManager.value(for: key))
//
//		subject
//			.receive(on: .main)
//			.sink {
//			print("SINK")
//			if self.didInit {
//				print("SET", $0)
//				PlistManager.set($0, for: key)
//			} else {
//				print("DIDINIt")
//				self.didInit = true
//			}
//		}.store(in: bag(self))
//	}
//}
//
//func getCachedInstanceOpt<T>(key: String) -> CachedInstanceOpt<T> {
//	if let instance = cachedInstances[key] as? CachedInstanceOpt<T> {
//		return instance
//	} else {
//		let new = CachedInstanceOpt<T>(key: key)
//		cachedInstances[key] = new
//		return new
//	}
//}


fileprivate var cachedInstances: [String: Any] = [:]
