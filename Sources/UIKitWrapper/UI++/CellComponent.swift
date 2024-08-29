//
//  Cell.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 11.05.2021.
//

import Foundation
import Carbon
import Combine
import CombineOperators
//import CombineCocoa
import UIKit
//public class CellComponent<Model: Equatable, Id: Hashable>: IdentifiableComponent {
//    public func intrinsicContentSize(for content: CellContent<Model>) -> CGSize {
//        .init(width: 0, height: UITableView.automaticDimension)
//    }
//    
//	public var id: Id { idFromModel(model) }
//	
//
//
//	public func renderContent() -> CellContent<Model> {
//		let cellView: CellContent<Model>! =
//		contentFrom.map { CellContent(model: model, contentFrom: $0) }
//		??
//		rxContentFrom.map { CellContent(model: model, contentFromPublisher: $0) }
//		return cellView
//	}
//	
//	public func render(in content: CellContent<Model>) { content.model = model }
//	
//	public func referenceSize(in bounds: CGRect) -> CGSize? { size }
//	
//	public func shouldContentUpdate(with next: CellComponent<Model, Id>) -> Bool { model != next.model }
//	
//	public typealias ID = Id
//	
//	public typealias Content = CellContent<Model>
//	
//	public func layout(content: CellContent<Model>, in container: UIView) {
//		let contentView =
//		container
//		
//		contentView.addSubview(content.view.fill())
//	}
//	
//	init(_ model: Model, id: @escaping (Model) -> Id, size: CGSize? = nil, rxContentFrom: @escaping (Rx<Model>) -> UIView ) {
//		self.model = model
//		self.rxContentFrom = rxContentFrom
//		self.size = size
//		idFromModel = id
//		
//	}
//	
//	init(_ model: Model, id: @escaping (Model) -> Id, size: CGSize? = nil , contentFrom: @escaping (Model) -> UIView ) {
//		self.model = model
//		self.contentFrom = contentFrom
//		self.size = size
//		idFromModel = id
//	}
//	
//	let model: Model
//
//	var size: CGSize?
//
//	var rxContentFrom : ((Rx<Model>) -> UIView)?
//	var contentFrom : ((Model) -> UIView)?
//
//	let idFromModel: (Model) -> Id
//	
//}
//
//public class CellContent<Model> {
//	@Rx var model: Model
//
//	public var view: UIView {
//		let view = UIView()
//		if let contentFrom = self.contentFrom {
//			$model.sink { [weak view] in
//				let newView = contentFrom($0)
//				view?.subviews.forEach { $0.removeFromSuperview() }
//				view?.addSubview(newView)
//				newView.fillToSuperview()
//			}.store(in: view.cb.asBag)
//		}
//		
//		if let contentFromPublisher = contentFromPublisher {
//			let newView = contentFromPublisher(_model)
//			view.addSubview(newView.fill())
//		}
//		
//		return view
//	}
//
//	public var contentFrom: ((Model) -> UIView)?
//
//	public var contentFromPublisher: ((Rx<Model>) -> UIView)?
//	
//	init(model: Model, contentFrom: @escaping (Model) -> UIView) {
//		self.model = model
//		self.contentFrom = contentFrom
//		print("Init CellContent")
//	}
//	
//	init(model: Model, contentFromPublisher: ((Rx<Model>) -> UIView)?) {
//		self.model = model
//		self.contentFromPublisher = contentFromPublisher
//		print("Init CellContent")
//	}
//	
//	deinit {
//		print("Deinit CellContent")
//	}
//}

class ReusableCellComponent: IdentifiableComponent {
    func intrinsicContentSize(for content: ReusableCellContent) -> CGSize {
        .init(width: 0, height: UITableView.automaticDimension)
    }
    
	var id: AnyHashable
    var isReusable = false
	var reuseIdentifier: String
    var viewMaker: ((Rx<Any>) -> UIView) = { _ in __ }
    var size: CGSize?
    var selection: (EquatableIdentifiable, IndexPath)->()
//    var eq: (Any, Any) -> Bool
//    public var id: (T) -> AnyHashable


	func renderContent() -> ReusableCellContent {
        ReusableCellContent(viewMaker: viewMaker, model: model, isReusable: isReusable)
    }

    func render(in content: ReusableCellContent) {
        content.model = model
        print("rendering\(content.model)")
    }

	func referenceSize(in bounds: CGRect) -> CGSize? { size }

	func shouldContentUpdate(with next: ReusableCellContent) -> Bool {
		true
//		!eq(next.model, model)
	}

	typealias ID = AnyHashable
	typealias Content = ReusableCellContent

	let model: Any

	func layout(content: ReusableCellContent, in container: UIView) {
        let view = content.view
        container.addSubview(view.fill())
        print(#function)
	}
	
    init(model: Any, reusableCell: ReusableCell, isReusable: Bool, id: AnyHashable
//		 , eq: @escaping (Any, Any) -> Bool
	) {
        ReusableCellComponentCNT += 1

        print("++ Init ReusableCell Component", ReusableCellComponentCNT)

		self.model = model
        self.size = reusableCell.size
        self.viewMaker = reusableCell.viewMaker
        self.reuseIdentifier = reusableCell.reuseId
        self.isReusable = isReusable
        self.selection = reusableCell.selection
//        self.eq = eq
        self.id = id
	}

    deinit {
        ReusableCellComponentCNT -= 1
        print("-- Deinit ReusableCell Component", ReusableCellComponentCNT)
    }
}
var ReusableCellComponentCNT = 0


class ReusableCellContent {

	@Rx var model: Any
    var makeView: (() -> UIView)
    var isReusable: Bool
    lazy var view = makeView()


    init(viewMaker: @escaping ((Rx<Any>) -> UIView), model: Any, isReusable: Bool) {
		self.model = model

        ReusableCellContentCNT += 1

		print("++ Init ReusableCellContent", ReusableCellContentCNT)
        self.makeView = { UIView() }
        self.isReusable = isReusable

        self.makeView = { [weak self] in
            guard let self else { return UIView() }

            if isReusable {
                return viewMaker(self._model)
            } else {
                return viewMaker(self._model)
            }
        }
	}
	
	deinit {
        ReusableCellContentCNT -= 1
		print("-- Deinit ReusableCellContent", ReusableCellContentCNT)
	}
}

var ReusableCellContentCNT = 0
