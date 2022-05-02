//
//  Collection+Table.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.05.2021.
//

import Combine
import UIKit
import CombineOperators
//import CombineCocoa
import Carbon
import VDKit
import SwiftUI

//struct ForEach:  {
//	let
//}
//
//protocol TableItemView {
//	var getView: UIView { get }
//	var reusableCell: ReusableCell  { get }
//}
//
//extension UIView: TableItemView {
//
//}

//extension StackItem:

open class TableView: UIView {

//	init(@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [() -> ComponentWrapper]) {
//		
//	}
	
//	public convenience init<O: Publisher>(
//		_ observableList: O,
//		tableView: UITableView = UITableView(),
//		adapter: UITableViewAdapter = UITableViewAdapter(),
//		insets: UIEdgeInsets = .zero,
//		@ArrayBuilder <StackItem> cells: @escaping () -> [ReusableCell]
//	) where O.Output == [EquatableIdentifiable] {
//		
//		
//	}
	
	public convenience init<O: Publisher>(
		_ observableList: O,
		tableView: UITableView = UITableView(),
		adapter: UITableViewAdapter = UITableViewAdapter(),
		insets: UIEdgeInsets = .zero,
		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
	) where O.Output == [EquatableIdentifiable] {
		
		
		@Rx var sections: [AnySection] = []
		
		self.init(
			$sections,
			tableView: tableView,
			adapter: adapter,
			insets: insets,
			reusableCells: reusableCells
		)
		
		observableList.map { list in [ AnySection(id: "0", cells: list) ] }.sink {
			sections = $0
		}.store(in: self.cb.asBag)
		
	}
	
	public init<O: Publisher>(
		_ observableList: O,
		tableView: UITableView = UITableView(),
		adapter: UITableViewAdapter = UITableViewAdapter(),
		insets: UIEdgeInsets = .zero,
		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
	) where O.Output == [AnySection]
	{
		self.tableView = tableView
		self.adapter = adapter
		tableView.backgroundColor = .clear
		super.init(frame: .zero)
		self.backgroundColor = .clear
		
		let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
		
		addSubview(tableView)
		tableView.fillToSuperview(top: insets.top,
																	 left: insets.left,
																	 right: insets.right,
																	 bottom: insets.bottom)
		observableList.sink { [weak self] sectionList in
			let sections = sectionList.map { section -> Carbon.Section in
				
				let list = section.cells
				
				
				let cells: [ReusableCellWrapper] = list.map {
					
					let reuseId = String(reflecting: type(of: $0))
					
					if let reusableCell = reusableCellsById[reuseId]?.first {
						print(String(reflecting: type(of: $0)))
						return ReusableCellWrapper(
							model: $0,
							reusableCell: reusableCell
						)
					} else {
						fatalError("Has no reusable cell for this model \(reuseId)")
					}
					
				}
				
				
				return Carbon.Section(
					id: section.id,
					header: section.header.map { ViewNode($0) },
					cells: cells.map(CellNode.init),
					footer: section.footer.map { ViewNode($0) }
				)
			}
			
			self?.renderer.render(
				sections
			)
			self?.renderer.adapter.didSelect = { context in
				let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
				let reuseId = String(reflecting: type(of: model))
				reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
			}
			
		}.store(in: self.tableView.cb.asBag)
		
		renderer.target = tableView
	}
	
	
	let renderer = Renderer(
		adapter: UITableViewAdapter(),
		updater: UITableViewUpdater()
	)
	let adapter: UITableViewAdapter

	public let tableView: UITableView
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
//
open class CollectionView: UIView {
	
	public convenience init<O: Publisher>(
		_ observableList: O,
		collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
		adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
		insets: UIEdgeInsets = .zero,
		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
	) where O.Output == [EquatableIdentifiable] {
		
		
		@Rx var sections: [AnySection] = []
		
		self.init(
			$sections,
			collectionView: collectionView,
			adapter: adapter,
			insets: insets,
			reusableCells: reusableCells
		)
		
		observableList.map { list in [ AnySection(id: "0", cells: list) ] }.sink {
			sections = $0
		}.store(in: self.cb.asBag)
		
	}
	
	public init<O: Publisher>(
		_ observableList: O,
		collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
		adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
		insets: UIEdgeInsets = .zero,
		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
	) where O.Output == [AnySection]
	{
		self.collectionView = collectionView
		self.adapter = adapter
		collectionView.backgroundColor = .clear
		super.init(frame: .zero)
		self.backgroundColor = .clear
		
		let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
		
		addSubview(collectionView)
		collectionView.fillToSuperview(top: insets.top,
																	 left: insets.left,
																	 right: insets.right,
																	 bottom: insets.bottom)
		observableList.sink { [weak self] sectionList in
			let sections = sectionList.map { section -> Carbon.Section in
				
				let list = section.cells
				
				
				let cells: [ReusableCellWrapper] = list.map {
					
					let reuseId = String(reflecting: type(of: $0))
					
					if let reusableCell = reusableCellsById[reuseId]?.first {
						print(String(reflecting: type(of: $0)))
						return ReusableCellWrapper(
							model: $0,
							reusableCell: reusableCell
						)
					} else {
						fatalError("Has no reusable cell for this model \(reuseId)")
					}
					
				}
				
				
				return Carbon.Section(
					id: section.id,
					header: section.header.map { ViewNode($0) },
					cells: cells.map(CellNode.init),
					footer: section.footer.map { ViewNode($0) }
				)
			}
			
			self?.renderer.render(
				sections
			)
			self?.renderer.adapter.didSelect = { context in
				let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
				let reuseId = String(reflecting: type(of: model))
				reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
			}
			
		}.store(in: self.collectionView.cb.asBag)
		
		renderer.target = collectionView
	}

	public init<O: Publisher, Id: Hashable, Model: Equatable>(
			_ observableList: O,
			id: @escaping (Model) -> Id,
			selection: ((Model) -> ())? = nil,
			collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
			adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
			size: ( (Model) -> CGSize?)? = nil,
			insets: UIEdgeInsets = .zero,
			cellConfig: @escaping (CellWrapper<Model, Id>) -> () = {_ in},
			rxContentFrom: @escaping (Rx<Model>) -> StackItem
	) where O.Output == [Model]
	{
			self.collectionView = collectionView
			self.adapter = adapter
			collectionView.backgroundColor = .clear
			super.init(frame: .zero)
			self.backgroundColor = .clear

			addSubview(collectionView)
			collectionView.fillToSuperview(top: insets.top,
																		 left: insets.left,
																		 right: insets.right,
																		 bottom: insets.bottom)
			observableList.sink { [weak self] list in

							let cells = list.map {
									CellWrapper(
											$0,
											id: id,
											size: size?($0),
											rxContentFrom: rxContentFrom
									)
							}

							cells.forEach(cellConfig)

							self?.renderer.render(
									Section(
											id: "section",
											cells: cells.map(CellNode.init)
									)
							)
							if let selection = selection {
									self?.renderer.adapter.didSelect = { context in
											let model = list[context.indexPath.row]
											selection(model)
									}
							}

			}.store(in: self.collectionView.cb.asBag)

			renderer.target = collectionView
	}
	
	let adapter: UICollectionViewAdapter
	
	lazy var renderer = Renderer(
		adapter: adapter,
		updater: UICollectionViewUpdater()
	)
	
	public let collectionView: UICollectionView
	
	required public  init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

public struct AnySection {
	public let id: String
	public var header: ComponentWrapper? = nil
	public var footer: ComponentWrapper? = nil
	public var size: CGSize? = nil
	public var cells: [EquatableIdentifiable]
	
	public init(
	 id: String,
	 header: ComponentWrapper? = nil,
	 footer: ComponentWrapper? = nil,
	 size: CGSize? = nil,
	 cells: [EquatableIdentifiable]
	) {
		self.id = id
		self.header = header
		self.footer = footer
		self.size = size
		self.cells = cells
	}
}

public extension StackItem {
	public func component(size: CGSize? = nil) -> ComponentWrapper {
		ComponentWrapper(view: self.getView, size: size)
	}
}

public struct ComponentWrapper: Component {
	public func renderContent() -> StackItem {
		view
	}
	
	public func render(in content: StackItem) {
		
	}
	
	public func layout(content: StackItem, in container: UIView) {
		container.addSubviews(content.getView.pin())
	}
	
	public func referenceSize(in bounds: CGRect) -> CGSize? {
		 size
	}
	
	public typealias Content = StackItem
	
	let view: StackItem
	var size: CGSize? = nil

}


public class ReusableCell {
	let reuseId: String
	let type: EquatableIdentifiable.Type
	let size: CGSize?
	var viewMaker: ((Rx<EquatableIdentifiable>) -> StackItem) = { _ in __}
	var selection: (EquatableIdentifiable, IndexPath)->()

	public init<Model: EquatableIdentifiable>(_ type: Model.Type, size: CGSize? = nil, selection: @escaping (Model, IndexPath)->(), view: @escaping (Rx<Model>) -> StackItem) {
		


		self.type = Model.self
		reuseId = String(reflecting: Model.self)
		print(reuseId)
		self.size = size
		self.selection = { item, ip in (item as? Model).map { selection($0, ip) } }

		let viewMaker: ((Rx<EquatableIdentifiable>) -> StackItem) = {  rxAny in
			@Rx var model: Model = rxAny.wrappedValue as! Model
			rxAny.sink {
				if let data = $0 as? Model {
					model = data
				}
			}.store(in: bag(self))
			return view(_model)
		}
		self.viewMaker = viewMaker
	}

}

//struct AnyIdentifiable: Identifiable {
//	var id: ObjectIdentifier
//
//
//	init(
//}


public struct EquitableWrapper<T: AnyEquatable>: Equatable {
		
	public static func == (l: EquitableWrapper<T>, r: EquitableWrapper<T>) -> Bool {
				return l.value.isEquialTo(r.value)
		}
		let value: T
}
public protocol AnyEquatable {
	func isEquialTo(_ another: Any) -> Bool

}
public extension AnyEquatable where Self: Equatable {
		func isEquialTo(_ another: Any) -> Bool {
				guard let another = another as? Self else { return false }
				return self == another
		}
}
public protocol EquatableIdentifiable: AnyEquatable {
	var modelID: AnyHashable { get }
}

public extension EquatableIdentifiable where Self: Identifiable, Self: Equatable {
	var modelID: AnyHashable { id }
}

public extension Hashable where Self: EquatableIdentifiable {
	var modelID: AnyHashable { self }
}

extension Array: AnyEquatable where Element: Equatable {
	public func isEquialTo(_ another: Any) -> Bool {
		guard let another = another as? [Element] else { return false }
		return self == another
	}
}

extension Array: EquatableIdentifiable where Element: EquatableIdentifiable, Element: Hashable {
	public var modelID: AnyHashable { self }
}

extension String: EquatableIdentifiable { }
extension Int: EquatableIdentifiable { }
extension Double: EquatableIdentifiable { }
												
