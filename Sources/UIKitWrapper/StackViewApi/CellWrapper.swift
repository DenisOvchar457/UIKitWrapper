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
public class CellWrapper<Model: Equatable, Id: Hashable>: IdentifiableComponent {
	public var id: Id { idFromModel(model) }
	
	public func renderContent() -> CellContent<Model> {
		let cellView: CellContent<Model>! =
		contentFrom.map { CellContent(model: model, contentFrom: $0) }
		??
		rxContentFrom.map { CellContent(model: model, contentFromPublisher: $0) }
		return cellView
	}
	
	public func render(in content: CellContent<Model>) { content.model = model }
	
	public func referenceSize(in bounds: CGRect) -> CGSize? { size }
	
	public func shouldContentUpdate(with next: CellWrapper<Model, Id>) -> Bool { model != next.model }
	
	public typealias ID = Id
	
	public typealias Content = CellContent<Model>
	
	public func layout(content: CellContent<Model>, in container: UIView) {
		let contentView =
		container
		
		contentView.addSubview(content.view.pin())
	}
	
	init(_ model: Model, id: @escaping (Model) -> Id, size: CGSize? = nil, rxContentFrom: @escaping (Rx<Model>) -> StackItem ) {
		self.model = model
		self.rxContentFrom = rxContentFrom
		self.size = size
		idFromModel = id
		
	}
	
	init(_ model: Model, id: @escaping (Model) -> Id, size: CGSize? = nil , contentFrom: @escaping (Model) -> StackItem ) {
		self.model = model
		self.contentFrom = contentFrom
		self.size = size
		idFromModel = id
	}
	
	let model: Model

	var size: CGSize?

	var rxContentFrom : ((Rx<Model>) -> StackItem)?
	var contentFrom : ((Model) -> StackItem)?
	
	let idFromModel: (Model) -> Id
	
}

public class CellContent<Model> {
	@Rx var model: Model
	
	
	public var view: UIView {
		let view = UIView()
		if let contentFrom = self.contentFrom {
			$model.sink { [weak view] in
				let newView = contentFrom($0).getView
				view?.subviews.forEach { $0.removeFromSuperview() }
				view?.addSubview(newView)
				newView.fillToSuperview()
			}.store(in: view.cb.asBag)
		}
		
		if let contentFromPublisher = contentFromPublisher {
			
			let newView = contentFromPublisher(_model)
			view.addSubview(newView.getView.pin())
		}
		
		return view
	}
	
	
	public var contentFrom: ((Model) -> StackItem)?
	
	public var contentFromPublisher: ((Rx<Model>) -> StackItem)?
	
	
	init(model: Model, contentFrom: @escaping (Model) -> StackItem) {
		self.model = model
		self.contentFrom = contentFrom
		print("Init CellContent")
	}
	
	init(model: Model, contentFromPublisher: ((Rx<Model>) -> StackItem)?) {
		self.model = model
		self.contentFromPublisher = contentFromPublisher
		print("Init CellContent")
	}
	
	deinit {
		print("Deinit CellContent")
	}
}

class ReusableCellWrapper: IdentifiableComponent {
	var id: AnyHashable { return model.modelID }
	
	var reuseIdentifier: String { reusableCell.reuseId }
	
	func renderContent() -> ReusableCellContent { ReusableCellContent(reusableCell: reusableCell, model: model) }
	
	func render(in content: ReusableCellContent) { content.model = model }
	
	func referenceSize(in bounds: CGRect) -> CGSize? { reusableCell.size }
	
	func shouldContentUpdate(with next: ReusableCellContent) -> Bool { model.isEquialTo(next.model) }
	
	typealias ID = AnyHashable
	typealias Content = ReusableCellContent
	
	
	let model: EquatableIdentifiable
	let reusableCell: ReusableCell
	
	
	func layout(content: ReusableCellContent, in container: UIView) {
		let contentView = container
		
		contentView.addSubview(content.view.pin())
	}
	
	init(model: EquatableIdentifiable, reusableCell: ReusableCell) {
		self.model = model
		self.reusableCell = reusableCell
	}
	
}

class ReusableCellContent {
	@Rx var model: EquatableIdentifiable
	var reusableCell: ReusableCell
	
	var view: UIView {
//		let view = UIView()
			
		let newView = reusableCell.viewMaker(_model)
//		view.addSubview(newView.getView.pin())
		
		return newView.getView
	}
	
	init(reusableCell: ReusableCell, model: EquatableIdentifiable) {
		self.model = model
		self.reusableCell = reusableCell
		print("Init CellContent")
	}
	
	deinit {
		print("Deinit CellContent")
	}
}
