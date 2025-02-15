//
//  TextField+TextView.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//
import UIKit
//import CombineCocoa
import CombineOperators
import Combine

#if canImport(InputMask)
import InputMask

public struct FieldState: Equatable {

    
	public var string: String
	public var error: Error? = nil

	public init(string: String, error: Error? = nil) {
		self.string = string
		self.error = error
	}


    public static func == (lhs: FieldState, rhs: FieldState) -> Bool {
        lhs.string == rhs.string && lhs.error?.localizedDescription == rhs.error?.localizedDescription
    }
}

//extension String {
//    FieldStatw
//}



public let fieldAutoscrollTag = 23421198


public extension UITextField {
    public convenience init(
        _ subject: Rx<String>,
        _ placeholder: String = "",
        listener: MaskedTextInputListener? = nil,
        updateForState: ((FieldState, UITextField) -> ())? = nil,
        showError: ((Error?, UITextField) -> ())? = nil,
        autoScrollSuperViewTag: Int? = fieldContainerTag
    ) {
        self.init(
            subject.mapSubject(get: { FieldState(string: $0) },
                               set: { subject.val = $0.string }),
            placeholder,
            listener: listener,
            updateForState: updateForState,
            showError: showError,
            autoScrollSuperViewTag: autoScrollSuperViewTag
        )
    }


    public convenience init(
        _ subject: Rx<FieldState>,
        _ placeholder: String = "",
        listener: MaskedTextInputListener? = nil,
        updateForState: ((FieldState, UITextField) -> ())? = nil,
        showError: ((Error?, UITextField) -> ())? = nil,
        autoScrollSuperViewTag: Int? = fieldContainerTag
    )
    {
        self.init()
        let field = self

        field.placeholder = placeholder
        field.textColor = textColor


//        func defaultsShow(error: Error?) {
//            self.border = error != nil ? (width: 1, color: .systemRed) : (width: 1, color: .clear)
//        }

        if let listener = listener {
            field.delegate = listener
            var kSomeKey = "textfieldkey"
            objc_setAssociatedObject(field, &kSomeKey, listener, .OBJC_ASSOCIATION_RETAIN)
            field.cb.text.map { $0 ?? "" }.removeDuplicates().sink {
                subject.wrappedValue.string = $0

            }.store(in: field.cb.asBag)
        } else {
            field.cb.text.map { $0 ?? "" }
                .removeDuplicates()
                .sink {
                    subject.wrappedValue.string = $0
                }.store(in: field.cb.asBag)
        }
        
        field.cb.didBeginEditing.sink { [weak field] in
            guard let field = field else { return }

            showError?(subject.wrappedValue.error, field) 
            updateForState?(subject.wrappedValue, field)


            if let autoScrolledTag = autoScrollSuperViewTag {
                (
                    field.findSuperview { $0.tag == fieldAutoscrollTag }
                    ??
                    field.findSuperview { $0.tag == autoScrolledTag }
                )?.makeVisibleInScroll()
            }
        }

        subject.map(\.string).removeDuplicates()// { $0.string == $1.string }
            .sink {
                field.text = $0.string
            }.store(in: field.cb.asBag)

        subject.map(\.error).removeDuplicates { $0?.localizedDescription == $1?.localizedDescription }// { $0.string == $1.string }
            .sink {
                showError?($0, field)
//                ?? defaultsShow(error: $0)
            }.store(in: field.cb.asBag)

        subject.removeDuplicates { $0.string == $1.string && $0.error?.localizedDescription == $1.error?.localizedDescription }
            .sink {
                updateForState?($0, field)
                //                    if let error = $0.error { show(error: error) }
                //                    field.text = $0.string
            }.store(in: field.cb.asBag)
    }

}

public func textField(placeholder: String = "",
							 subject: CurrentValueSubject<FieldState,
							 Never>,
							 listener: MaskedTextInputListener? = nil,
							 bgColor: UIColor = .gray.withAlphaComponent(0.5),
                            textColor: UIColor = .black,
							 autoScrollSuperViewTag: Int? = fieldContainerTag
) -> UITextField {
	UITextField().apply { field in
		field.placeholder = placeholder
		field.textColor = textColor
		
		func show(error: Error) {
			
		}
		
		if let listener = listener {
			field.delegate = listener
			var kSomeKey = "textfieldkey"
			objc_setAssociatedObject(field, &kSomeKey, listener, .OBJC_ASSOCIATION_RETAIN)
			field.cb.text.map { $0 ?? "" }.removeDuplicates().sink {
				subject.value.string = $0
			}.store(in: field.cb.asBag)
		} else {
			field.cb.text.map { $0 ?? "" }.removeDuplicates().sink {
				subject.value.string = $0
			}.store(in: field.cb.asBag)
		}

		field.cb.didBeginEditing.sink { [weak field] in
			guard let field = field else { return }
			if subject.value.error == nil {
				field.backgroundColor = bgColor
			}
			if let autoScrolledTag = autoScrollSuperViewTag {
				(
					field.findSuperview { $0.tag == fieldAutoscrollTag }
					??
					field.findSuperview { $0.tag == autoScrolledTag }
				)?.makeVisibleInScroll()
			}
		}.store(in: field.cb.asBag)

        subject.map(\.string).removeDuplicates()// { $0.string == $1.string }
            .sink {
                field.text = $0.string
            }.store(in: field.cb.asBag)

		subject.removeDuplicates { $0.string == $1.string && $0.error?.localizedDescription == $1.error?.localizedDescription }
		.sink {

			if let error = $0.error { show(error: error) }
			field.text = $0.string
		}.store(in: field.cb.asBag)
	}
}



public let fieldContainerTag = 234235231


public func textView(placeholder: String = "",
							subject: CurrentValueSubject<FieldState, Never>,
							listener: MaskedTextInputListener? = nil,
							autoScrollSuperViewTag: Int? = fieldContainerTag,
							placeholderTextColor: UIColor = .gray,
							placeholderFont: UIFont = .systemFont(ofSize: 16),
							bgColor: UIColor = .gray.withAlphaComponent(0.3)
							//, regex: String? = nil
) -> UITextView {
	UITextView().apply { field in
		//        field.placeholder = placeholder
		
		let placeholderLabel = UILabel()
		DispatchQueue.main.async {
			placeholderLabel.text = placeholder
			placeholderLabel.font = placeholderFont////UIFont.italicSystemFont(ofSize: (field.font?.pointSize)!)
			placeholderLabel.sizeToFit()
			field.addSubview(placeholderLabel)
			placeholderLabel.frame.origin = CGPoint(x: 20, y: (field.font?.pointSize)! / 2)
			placeholderLabel.textColor = .gray
		}
		
		
		
//		field.tintColor = .blue//.rgb(42, 226, 120)
		field.backgroundColor = .clear
		
		//        DispatchQueue.main.async {
		//            field.delegate = TMPTextViewDelegate(holder: field)
		//        }
		
		func show(error: Error) {
			
		}
		
		//        DispatchQueue.main.async {
		//TODO: филды текут мб раз они в блоке и они бэги
		if let listener = listener {
			field.delegate = listener
			var kSomeKey = "textfieldkey"
			objc_setAssociatedObject(field, &kSomeKey, listener, .OBJC_ASSOCIATION_RETAIN)
			
			//TODO: cb.text починить
			
			//                field.cb.text.map { $0 ?? "" }.removeDuplicates().sink {
			//                    subject.value.string = $0
			//                    placeholderLabel.isHidden = !field.text.isEmpty
			//                }.store(in: field.cb.asBag)
//			field.cb.text?.sink {
//				
//			}.store(in: field.cb.asBag)
			field.cb.mayChange.sink { [weak field] _,_ in
				guard let field = field else { return }
				subject.value.string = field.text
				placeholderLabel.isHidden = !field.text.isEmpty
			}.store(in: field.cb.asBag)
		} else {
			//                field.cb.text.map { $0 ?? "" }.removeDuplicates().sink {
			//                    subject.value.string = $0
			//                    placeholderLabel.isHidden = !field.text.isEmpty
			//                }.store(in: field.cb.asBag)
			
			field.cb.mayChange.sink { [weak field] _, _ in
				guard let field = field else { return }
				subject.value.string = field.text
				placeholderLabel.isHidden = !field.text.isEmpty
			}.store(in: field.cb.asBag)
		}
		
		field.cb.didBeginEditing.sink { [weak field] in
			guard let field = field else { return }
			if subject.value.error == nil {
				field.backgroundColor = bgColor

			}
			if let autoScrolledTag = autoScrollSuperViewTag {
				(
					field.findSuperview { $0.tag == fieldAutoscrollTag }
					??
					field.findSuperview { $0.tag == autoScrolledTag }
				)?.makeVisibleInScroll()
			}
		}.store(in: field.cb.asBag)
		
		field.cb.mayEndEditing.sink { [weak field] in
			guard let field = field else { return }
			if subject.value.error == nil {
				field.backgroundColor = .clear
			}
			
		}.store(in: field.cb.asBag)
		//        }
		
		
		
		subject.removeDuplicates { $0.string == $1.string && $0.error?.localizedDescription == $1.error?.localizedDescription }
		.sink {
			if let error = $0.error { show(error: error) }
			field.text = $0.string
		}.store(in: field.cb.asBag)
	}
}
#endif
