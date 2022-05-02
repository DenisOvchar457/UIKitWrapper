//
//  Exts.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import UIKit
//import CombineCocoa
import CombineOperators
import Combine

public extension Equatable {
	mutating func apply(_ block: (inout Self) -> Void ) -> Self {
		block(&self)
		return self
	}
	func apply(_ block: (Self) -> Void ) -> Self {
				 block(self)
				 return self
	}
}


public extension UIColor {
	static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
		return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
	
	static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
		return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
}

public typealias Res<Value> = Result<Value, Error>

public func retain(holder: NSObject, object: NSObject) {
	var key = String(Int.random(in: Int.min...Int.max))
	
	associateObject(base: holder, key: key, value: object)
}

//public extension UITextField {
//    var isEditing: Bool {
//        get { isFirstResponder }
//        set { newValue ? becomeFirstResponder() : resignFirstResponder() }
//    }
//}




public extension UITextInput where Self: Equatable {
	
	
	func editNextField(commonContainer: UIView? = keyWindow) {
		let textFields: [UIView]? = commonContainer?.allSubviews(of: UITextField.self, and: UITextView.self)
		let indexOfCurrent = textFields?.firstIndex { $0 === self }
		
		indexOfCurrent.map { index in
			DispatchQueue.main.async {
				(textFields?[safe: index + 1] as? UITextView)?.becomeFirstResponder()
				(textFields?[safe: index + 1] as? UITextField)?.becomeFirstResponder()
			}
		}
	}
	
	func editPrevField(commonContainer: UIView? = keyWindow) {
		let textFields: [UIView]? = commonContainer?.allSubviews(of: UITextField.self, and: UITextView.self)
		let indexOfCurrent = textFields?.firstIndex { $0 === self }
		
		indexOfCurrent.map { index in
			DispatchQueue.main.async {
				(textFields?[safe: index - 1] as? UITextView)?.becomeFirstResponder()
				(textFields?[safe: index - 1] as? UITextField)?.becomeFirstResponder()
			}
		}
	}
	
}
public extension UITextField {
	func addArrowsToolbar() {
		
		
		inputAccessoryView = toolbar(holder: self)
	}
}

public extension UITextView {
	func addArrowsToolbar() {
		inputAccessoryView = toolbar(holder: self)
		
	}
}

private func toolbar(holder: UIView&UITextInput) -> UIToolbar {
	let toolbar = UIToolbar()
	toolbar.barTintColor = .rgb(30, 41, 97)
	toolbar.isTranslucent = true
	toolbar.sizeToFit()
	
	let marginView = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
	marginView.width = 10
	
	let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
	
	if #available(iOS 11.0, *) {
		let spaceBetweenButtons = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
		spaceBetweenButtons.width = 10
		
		toolbar.setItems(
			[
				marginView,
				UIBarButtonItem(customView: UIImage(systemName: "chevron.left")!.imageView( width: 40, height: 40).onTap {
					holder.editPrevField(commonContainer: keyWindow)
				}),
				spaceBetweenButtons,
				UIBarButtonItem(customView: UIImage(systemName: "chevron.right")!.imageView( width: 40, height: 40).onTap {
					holder.editNextField(commonContainer: keyWindow)
				}),
				flexibleSpace,
				UIBarButtonItem(customView: "Done".label().onTap {
					holder.editNextField(commonContainer: keyWindow)
				}),
				marginView
			], animated: false)
		
	} else {
		
	}
	
	return toolbar
}

public func animate(_ duration: Double = 0.3, _ block: @escaping () -> Void ) {
	UIView.animate(withDuration: duration) {
		block()
	}
}

public extension UIView {
	public func allSubviews<T: UIView, T2: UIView>(of type: T.Type, and type2: T2.Type) -> [UIView] {
		return allSubviews().compactMap({ $0 as? T ?? $0 as? T2 })
	}
}

public extension UIView {
	
	// Using a function since `var image` might conflict with an existing variable
	// (like on `UIImageView`)
	func asImage() -> UIImage {
		if #available(iOS 10.0, *) {
			let renderer = UIGraphicsImageRenderer(bounds: bounds)
			return renderer.image { rendererContext in
				layer.render(in: rendererContext.cgContext)
			}
		} else {
			UIGraphicsBeginImageContext(self.frame.size)
			self.layer.render(in:UIGraphicsGetCurrentContext()!)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			return UIImage(cgImage: image!.cgImage!)
		}
	}
}

public extension UIImage {
	static func textEmbeded(image: UIImage,
													string: String,
													isImageBeforeText: Bool,
													segFont: UIFont? = nil,
													segColor: UIColor? = nil) -> UIImage {
		let font = segFont ?? UIFont.systemFont(ofSize: 16)
		let expectedTextSize = (string as NSString).size(withAttributes: [.font: font])
		let width = expectedTextSize.width + image.size.width + 5
		let height = max(expectedTextSize.height, image.size.width)
		let size = CGSize(width: width, height: height)
		
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { context in
			let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2
			let textOrigin: CGFloat = isImageBeforeText
			? image.size.width + 5
			: 0
			let textPoint: CGPoint = CGPoint.init(x: textOrigin, y: fontTopPosition)
			string.draw(at: textPoint, withAttributes: [.font: font, .foregroundColor: segColor])
			let alignment: CGFloat = isImageBeforeText
			? 0
			: expectedTextSize.width + 5
			let rect = CGRect(x: alignment,
												y: (height - image.size.height) / 2,
												width: image.size.width,
												height: image.size.height)
			image.draw(in: rect)
		}
	}
}


public extension UICollectionViewFlowLayout {
	convenience init(size: CGSize, vertical: Bool = true) {
		self.init()
		itemSize = .init(width: size.width, height: size.height)
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = vertical ? .vertical : .horizontal
	}
}

public extension UICollectionView {
	convenience init(_ layout: UICollectionViewLayout) {
		self.init(frame: .zero, collectionViewLayout: layout)
	}
}

