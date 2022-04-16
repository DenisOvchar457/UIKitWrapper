//
//  Union.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 08.06.2021.
//

import Foundation
import SwiftUI
import VDKit

func generateUnions() -> String {
	(2...4).map {
				generateU(n: $0)
		}.joined(separator: "\n")
}

func generateN(n: Int, separator: String = ",", block: (String) -> String ) -> String {
		(0..<n).map { $0.string }.map (block).joined(separator: separator)
}

func generateU(n: Int) -> String {
		let N = String(n)
		return """
public struct U\(N)<\(generateN(n: n) { "A" + $0 } )> {

	let value: Any

	@discardableResult func match<T>(
		\( (0..<n).map { $0.string }.map { "_ a\($0): MatchEntry<A\($0),T>" }.joined(separator: ",\n                 "))
	) -> T {
		\(generateN(n: n, separator: " ??\n                 ") { "value(A\($0).self).map( a\($0).block)" })!
	}

	@discardableResult func match<T>(
		\( (0..<n).map { $0.string }.map { "_ a\($0): MatchEntry<A\($0),T>? = nil" }.joined(separator: ",\n                 "))
			,el: (U\(N)) -> T
	) -> T {

\(generateN(n: n, separator: "\n") {
"""
		if let a\($0) = a\($0), let value = value(A\($0).self) {
			return a\($0).block(value)
		}
"""
})
			return el(self)
	}

\((0..<n).map { $0.string }.map {
"""
	var a\($0): A\($0)? { value(A\($0).self) }
		
	init(_ value: A\($0)) {
		self.value = value
	}
	
	func value(_ type: A\($0).Type) -> A\($0)? {
		return value as? A\($0)
	}
	
	subscript(_ type: A\($0).Type) -> A\($0)? {
		return value as? A\($0)
	}

"""
}.joined())
}

public extension U\(N): Equatable where \(generateN(n: n) { ("A" + $0) + ": Equatable" } )  {

	static func == (lhs: U\(N)<\(generateN(n: n) { "A" + $0 } )>, rhs: U\(N)<\(generateN(n: n) { "A" + $0 } )>)
 -> Bool
	{
		return \( generateN(n: n, separator: " && ") { "lhs.a" + $0 + " == " + "rhs.a" + $0 } )
	}
}

public extension U\(N): Hashable where \(generateN(n: n) { ("A" + $0) + ": Hashable" } ) {
	func hash( into: inout Hasher) {
		into.combine(\( generateN(n: n, separator: " ?? ") { "a" + $0 + "?.hashValue" } ) ?? 0)
	}
}
"""
}


public struct unionPreview_Previews: PreviewProvider {
	public static var previews: some View {
			repl(//offset: .xy(50,300),
				generateU(n: 3)
			).swiftUI
		}
}
//typealias Opt<T> = U2<T, ()>
//
//typealias Reslt<T> = U3<T, Error, ()>
////
////
////struct Nothing {}
//
//func foo5() {
//		let res = Reslt(5)
//
//		let string = res.match(
//				Int.self >> { "ето инт" + String($0) },
//				Error.self >> { $0 },
//				Void.self >> { "" }
//		)
//
////    res.value(<#T##type: Int.Type##Int.Type#>)
//		res.match(
//				Int.self >> { _ in "" },
//				el: { _ in " " }
//		)
//}


public class MatchEntry<T, Out>: MatchEntryAbstract<Out> {
		let type: T.Type
		let block: (T) -> Out
		
		init(_ type: T.Type, _ block: @escaping (T)->Out) {
				self.type = type
				self.block = block
		}
	
	override func resultIfMatches(value: Any) -> Out? {
		ass(value, type: type).map(block)
	}
}

public class MatchEntryAbstract<Out> {
	func resultIfMatches(value: Any) -> Out? {
		nil
	}
}

infix operator >> : MultiplicationPrecedence

func >><T,Out> (lhs: T.Type, rhs: @escaping (T)->Out) -> MatchEntry<T,Out> {
		return MatchEntry(lhs, rhs)
}

//func >><T,Out> (lhs: T.Type, rhs: @autoclosure @escaping ()->Out) -> MatchEntry<T,Out> {
//    return MatchEntry(lhs, rhs())
//}

//extension U2: Codable where A0: Codable, A1: Codable {
//    struct CodingError: Error {
//        let error0: Error
//        let error1: Error
//    }
//
//    func encode(to encoder: Encoder) throws {
//        do {
//            try value(A0.self)?.encode(to: encoder)
//            try value(A1.self)?.encode(to: encoder)
//        }
//        catch {
//            throw error
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//
//        do {
//            let a0 = try A0(from: decoder)
//            self.value = a0
//        } catch {
//            let error0 = error
//            do {
//                let a1 = try A1(from: decoder)
//                self.value = a1
//            } catch {
//                throw CodingError(error0: error0, error1: error)
//            }
//        }
//
//    }
//}
//
//
//
//extension U2: Equatable where A0: Equatable, A1: Equatable {
//    static func == (lhs: U2<A0,A1>, rhs: U2<A0,A1>) -> Bool {
//        return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1
//    }
//}
//
//extension U2: Hashable where A0: Hashable, A1: Hashable {
//    var hashValue: Int {
//        return a0.hashValue ?? a1.hashValue ?? 0
//    }
//}
//
//
//extension U3: Codable where A0: Codable, A1: Codable, A2: Codable {
//    struct CodingError: Error {
//        let error0: Error
//        let error1: Error
//        let error2: Error
//    }
//
//    func encode(to encoder: Encoder) throws {
//        do {
//            try value(A0.self)?.encode(to: encoder)
//            try value(A1.self)?.encode(to: encoder)
//            try value(A2.self)?.encode(to: encoder)
//        }
//        catch {
//            throw error
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//
//        do {
//            let a0 = try A0(from: decoder)
//            self.value = a0
//        } catch {
//            let error0 = error
//            do {
//                let a1 = try A1(from: decoder)
//                self.value = a1
//            } catch {
//                let error1 = error
//                do {
//                    let a2 = try A2(from: decoder)
//                    self.value = a2
//                } catch {
//                    throw CodingError(error0: error0, error1: error1, error2: error)
//                }
//            }
//        }
//
//    }
//}
//
//
//
//extension U3: Equatable where A0: Equatable, A1: Equatable, A2: Equatable {
//    static func == (lhs: U3<A0,A1,A2>, rhs: U3<A0,A1,A2>) -> Bool {
//        return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1 && lhs.a2 == rhs.a2
//    }
//}
//
//extension U3: Hashable where A0: Hashable, A1: Hashable, A2: Hashable {
//    var hashValue: Int {
//        return a0.hashValue ?? a1.hashValue ?? a2.hashValue ?? 0
//    }
//}
//
//
//
//extension U4: Codable where A0: Codable, A1: Codable, A2: Codable, A3: Codable {
//    struct CodingError: Error {
//        let error0: Error
//        let error1: Error
//        let error2: Error
//        let error3: Error
//    }
//
//    func encode(to encoder: Encoder) throws {
//        do {
//            try value(A0.self)?.encode(to: encoder)
//            try value(A1.self)?.encode(to: encoder)
//            try value(A2.self)?.encode(to: encoder)
//            try value(A3.self)?.encode(to: encoder)
//
//        }
//        catch {
//            throw error
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//
//        do {
//            let a0 = try A0(from: decoder)
//            self.value = a0
//        } catch {
//            let error0 = error
//            do {
//                let a1 = try A1(from: decoder)
//                self.value = a1
//            } catch {
//                let error1 = error
//                do {
//                    let a2 = try A2(from: decoder)
//                    self.value = a2
//                } catch {
//                    let error2 = error
//                    do {
//                        let a3 = try A3(from: decoder)
//                        self.value = a3
//                    } catch {
//                        throw CodingError(error0: error0, error1: error1, error2: error2, error3: error)
//                    }
//
//                }
//            }
//        }
//
//    }
//}
//
//
//
//extension U4: Equatable where A0: Equatable, A1: Equatable, A2: Equatable, A3: Equatable {
//    static func == (lhs: U4<A0,A1,A2,A3>, rhs: U4<A0,A1,A2, A3>) -> Bool {
//        return lhs.a0 == rhs.a0 && lhs.a1 == rhs.a1 && lhs.a2 == rhs.a2 && lhs.a3 == rhs.a3
//    }
//}
//
//extension U4: Hashable where A0: Hashable, A1: Hashable, A2: Hashable, A3: Hashable {
//    var hashValue: Int {
//        return a0.hashValue ?? a1.hashValue ?? a2.hashValue ?? a3.hashValue ?? 0
//    }
//}
//
//
