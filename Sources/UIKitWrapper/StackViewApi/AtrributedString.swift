//
//  AtrributedString.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 15.04.2021.
//

import Foundation
import VDKit
import UIKit


private func example() -> AttributableString {
	[
		["asdfadfsf".link().textColor(.red),
		 "blya".spacing(10)]
			.paragraphStyle(.init(alignment: .center)),
		"addfasdfad".font(.systemFont(ofSize: 12))
	]
}

@Attributed private func exampleBuilder(bool: Bool) -> AttributableString {
	Attr {
		"some String".textColor(.red).underline().spacing(3)
		if bool {
			"anotherString"
				.textColor(.blue)
				.link(URL(string: "www.google.com")!)
				.font(.systemFont(ofSize: 12))
			Attr {
				"Another 1".textColor(.yellow)
				"Another 2"
			}.spacing(3)
		}
	}.font(.systemFont(ofSize: 30))
	"..."
}

typealias Attributed = ArrayBuilder<AttributableString>


func Attr(@ArrayBuilder<AttributableString> strings: () -> [AttributableString]) -> NSMutableAttributedString {
	return strings().attributedString
}


public protocol AttributableString {
	var attributedString: NSMutableAttributedString { get }
}

extension NSMutableAttributedString: AttributableString {
	
	public var attributedString: NSMutableAttributedString {
		self
	}
	
	
}
extension String: AttributableString {
	public var attributedString: NSMutableAttributedString {
		NSMutableAttributedString(string: self)
	}
}

extension Array: AttributableString where Element == AttributableString {
	public var attributedString: NSMutableAttributedString {
		self.reduce(NSMutableAttributedString(), { $0 + $1.attributedString})
	}
}


public extension AttributableString {
	
	func underline(_ style: NSUnderlineStyle = .single, color: UIColor? = nil) -> NSMutableAttributedString {
		attributedString.attributed(.underline(style, color: color))
	}
	
	func link(_ url: URL = URL(string: "www.google.com")!, underlined: Bool = true) -> NSMutableAttributedString {
		attributedString.attributed(.link(url, underlined: underlined))
	}
	
	func font(_ font: UIFont) -> NSMutableAttributedString {
		attributedString.attributed(.font(font))
	}
	
	//    func kern(_ font: UIFont) -> NSAttributedString {
	//        return NSAttribute([NSAttributedString.Key.font : font])
	//    }
	
	func textColor(_ color: UIColor) -> NSMutableAttributedString {
		attributedString.attributed(.textColor(color))
	}
	
	func spacing(_ spacing: CGFloat) -> NSMutableAttributedString {
		attributedString.attributed(.spacing(spacing))
	}
	
	func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSMutableAttributedString {
		attributedString.attributed(.paragraphStyle(style))
	}
	
}

public class NSAttribute {
	let attributes: [NSAttributedString.Key: Any]
	
	init(_ dict: [NSAttributedString.Key: Any]) {
		self.attributes = dict
	}
	
	public static func underline(_ style: NSUnderlineStyle = .single, color: UIColor? = nil) -> NSAttribute {
		let colorAttr = color.map { NSAttribute([NSAttributedString.Key.underlineColor: $0]) }
		return NSAttribute([NSAttributedString.Key.underlineStyle : style.rawValue] + (colorAttr?.attributes ?? [:]))
	}
	
	public static func link(_ url: URL = URL(string: "www.google.com")!, underlined: Bool = true) -> NSAttribute {
		var result = NSAttribute([NSAttributedString.Key.link : url])
		if underlined { result = result + .underline(.single) }
		return result
	}
	
	public static func font(_ font: UIFont) -> NSAttribute {
		return NSAttribute([NSAttributedString.Key.font : font])
	}
	
	//    static func kern(_ font: UIFont) -> NSAttribute {
	//        return NSAttribute([NSAttributedString.Key.font : font])
	//    }
	
	public static func textColor(_ color: UIColor) -> NSAttribute {
		return NSAttribute([NSAttributedString.Key.foregroundColor : color])
	}
	
	public static func spacing(_ spacing: CGFloat) -> NSAttribute {
		return NSAttribute([NSAttributedString.Key.kern : spacing])
	}
	
	public static func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttribute {
		return NSAttribute([NSAttributedString.Key.paragraphStyle : style])
	}
	
	
	public static func +(lhs: NSAttribute, rhs: NSAttribute) -> NSAttribute {
		return NSAttribute(lhs.attributes + rhs.attributes)
	}
	
}

public extension Dictionary where Key == NSAttributedString.Key {
	public static func with(_ attributes: NSAttribute...) -> [NSAttributedString.Key: Any] {
		attributes.dictionary
	}
}

public extension NSAttributedString {
	convenience init(_ string: String, attributes: [NSAttribute]) {
		let attributesDictionary = attributes.dictionary
		
		self.init(string: string, attributes: attributesDictionary)
	}
	convenience init(_ string: String, attribute: NSAttribute) {
		
		self.init(string: string, attributes: attribute.attributes)
	}
}

public extension Collection where Element: NSAttribute {
	var dictionary: [NSAttributedString.Key: Any] {
		return self.map { $0.attributes }
		.reduce([:], +)
	}
}

public extension String {
	func attributed(_ attributes: NSAttribute...) -> NSMutableAttributedString {
		
		return NSMutableAttributedString(self, attributes: attributes)
	}
	func attributed(attributes: [NSAttribute]) -> NSMutableAttributedString {
		
		return NSMutableAttributedString(self, attributes: attributes)
	}
}


public extension NSAttributedString {
	static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
		let left = NSMutableAttributedString(attributedString: lhs)
		
		left.append(rhs)
		return left
	}
	
	static func +(lhs: String, rhs: NSAttributedString) -> NSMutableAttributedString {
		let left = NSMutableAttributedString(attributedString: lhs.attributed())
		
		left.append(rhs)
		return left
	}
	
	static func +(lhs: NSAttributedString, rhs: String) -> NSMutableAttributedString {
		let left = NSMutableAttributedString(attributedString: lhs)
		left.append(rhs.attributed())
		return left
	}
	
	func attributed(_ attributes: NSAttribute...) -> NSMutableAttributedString {
		let mutable = NSMutableAttributedString(attributedString: self)
		mutable.enumerateAttributes(in: NSMakeRange(0, self.string.count), options: []) { attrs, subrange, pointer in
			let newAttrs = attrs.merging(attributes.dictionary, uniquingKeysWith: { a,b in a })
			mutable.setAttributes(newAttrs, range: subrange)
		}
		return mutable
	}
}

public extension NSMutableParagraphStyle {
	convenience init(alignment: NSTextAlignment) {
		self.init()
		self.alignment = alignment
	}
}
