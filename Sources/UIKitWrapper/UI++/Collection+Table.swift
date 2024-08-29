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
import FoundationExtensions
import SwiftUI


public struct EmptyModel {
//    public var modelID: AnyHashable

//    public func isEquialTo(_ another: Any) -> Bool {
////        true
//        false
////        guard let another = another as? EmptyModel else { return false }
////        return modelID == another.modelID
//    }
}

public protocol CellsProtocol {
    associatedtype T
    var content: (Rx<T>) -> UIView { get }
//    var id: (T) -> AnyHashable { get }
//    var eq: (Any, Any) -> Bool { get }
    var reuseIdentifier: String { get }
    var list: [(model: T, id: AnyHashable)] { get }
    var selection: ((T?, IndexPath)->())? { get }
    var shouldReuse: Bool { get }
}

public struct UICell<T>: CellsProtocol {
//    public var id: (T) -> AnyHashable
    
//    public var eq: (Any, Any) -> Bool

    public var shouldReuse: Bool { true }

    public var content: (CombineOperators.ValueSubject<T>) -> UIView

    public var reuseIdentifier: String

    public var list: [(model: T, id: AnyHashable)]


    public var selection: ((T?, IndexPath) -> ())?

//    public typealias T = T

//    public init(
//        id: AnyHashable? = nil,
////		eq: @escaping (Any, Any) -> Bool = { _,_ in false },
//        reuseId: String? = nil,
//        file: String = #file, line: Int = #line, column: Int = #column,
//        selection: (()->())? = nil,
//        @Builder<UIView> content: @escaping () -> UIView
//    ) where T == EmptyModel {
//
////        self.id = { _ in id ?? UUID().uuidString as AnyHashable }
//
//        self.list = [(EmptyModel(), id ?? UUID() as AnyHashable)]
//        self.reuseIdentifier = reuseId ?? (String(line) + file + String(column))
//        // " reuse"
////            reuseId ?? id
////        reuseId ?? UUID().uuidString
//        self.selection = { _, _ in selection?() }
//        self.content =  { _ in content() }
////		self.eq = eq
//    }



    public init(
        _ model: T,
        id: ((T) -> AnyHashable)? = nil,
//		eq: @escaping (Any, Any) -> Bool = { _,_ in false },
        selection: (()->())? = nil,
        reuseId: String? = nil,
        file: String = #file, line: Int = #line, column: Int = #column,
        @Builder<UIView> content: @escaping (Rx<T>) -> UIView
    ) {
//        self.id = { _ in id?(model) ?? UUID().uuidString as AnyHashable }

        let defaultId = (String(line) + file + String(column))

        self.list = [
			(model,
			 id?(model) ?? defaultId as AnyHashable)
		]
        self.reuseIdentifier = reuseId ?? (String(line) + file + String(column))
        self.selection = { _, _ in selection?() }
        self.content = content
//		self.eq = eq
    }


//    public init<Model>(
//        _ model: T,
//        id: String? = nil,
//        reuseId: String? = nil,
//        file: String = #file, line: Int = #line, column: Int = #column,
//        selection: ((T?, IndexPath)->())? = nil,
//        @Builder<UIView> content: @escaping (Rx<Model>) -> UIView
//    ) where T == Identified<Model> {
//        self.list = [model]
//        self.reuseIdentifier = reuseId ?? (String(line) + file + String(column))
//        self.selection = selection
//
//
//        self.content = { rx in
//            content(
//                rx.mapSubject(get: { $0.model },
//                              set: { _ in })
//            )
//        }
//    }
}

public struct UISection {
    public let id: String
    public var header: ComponentWrapper? = nil
    public var footer: ComponentWrapper? = nil
    public var size: CGSize? = nil
    public var cells: [any CellsProtocol]

    public init(
        id: String? = nil,
        file: String = #file, line: Int = #line, column: Int = #column,
        header: ComponentWrapper? = nil,
        footer: ComponentWrapper? = nil,
        size: CGSize? = nil,
        @ArrayBuilder<CellsProtocol> cells: @escaping () -> [any CellsProtocol]
    ) {
        let id = id ?? (String(line) + file + String(column))

        self.id = id
        self.header = header
        self.footer = footer
        self.size = size
        self.cells = cells()
    }
}

public struct UICells<T: EquatableIdentifiable>: CellsProtocol {
//    public var eq: (Any, Any) -> Bool
    public var id: (T) -> AnyHashable
    public var reuseIdentifier: String
    public var shouldReuse: Bool { true }
    public var list: [(model: T, id: AnyHashable)]
    public var selection: ((T?, IndexPath)->())?
    public var content: (Rx<T>) -> UIView

    public init(
        _ list: [T],
        reuseId: String? = nil,
//		eq: @escaping (Any, Any) -> Bool = { _,_ in false },
        id: @escaping ((T) -> AnyHashable),
        file: String = #file, line: Int = #line, column: Int = #column,
        selection: @escaping (T?, IndexPath)->() = { _,_ in },
        @Builder<UIView> content: @escaping (Rx<T>) -> UIView
    )
    {
        self.id = id
        self.list = list.map { ($0, id($0)) }
        self.selection = selection
        self.content =  { content($0).getView }
        self.reuseIdentifier = reuseId ?? (String(line) + file + String(column))
//		self.eq = eq
    }

}

//public extension UIView {
//    func uiCell(id: String? = nil,
//                file: String = #file, line: Int = #line, column: Int = #column,
//                selection: (()->())? = nil
//    ) -> any CellsProtocol {
////        let id = id ?? UUID().uuidString
//
//        let id = id ?? UUID().uuidString
//        let reuseId = id
////        (String(line) + file + String(column))
//        return UICell(id: id, reuseId: reuseId, selection: selection, content: { self })
//    }
//}

//func print(_ args: Any...) {
//
//}

extension UITableView {
    
    public convenience init<O: Publisher, Adapter: UITableViewAdapter>(
        _ data: O,
        style: UITableView.Style = .plain,
        adapter: Adapter = UITableViewAdapter(),
//        arr: [String] = [String].init(repeating: "sdsdssd", count: 1000000),
        updater: UITableViewUpdater<Adapter> = UITableViewUpdater(),
        @ArrayBuilder<[UISection]> cellSections: @escaping (O.Output) -> [[UISection]]
    ) {
        let adapter = adapter
        self.init(frame: .zero, style: style)
        self.backgroundColor = .clear

        var reusableCellsById: [String: ReusableCell] = [:]
//        var arr = arr
//        print(arr)
        let renderer = Renderer(
            adapter: adapter,
            updater: updater
        )

        renderer.target = self

        var isFirstRender = true

        data
            .receive(on: .main)
            .sink { data in

                let sections = cellSections(data)

                func cellsToReusableComponents(_ cells: any CellsProtocol) -> [ReusableCellComponent] {
                    let reuseId = cells.reuseIdentifier
                    if cells.shouldReuse {

                        let reusableCell = {
                            if let cell = reusableCellsById[reuseId] {
                                return cell
                            } else {
                                let new = ReusableCell(cells: cells)
                                reusableCellsById[reuseId] = new
                                return new
                            }
                        }()

                        return cells.list.map {
                            ReusableCellComponent(model: $0.model,
                                                  reusableCell: reusableCell,
                                                  isReusable: true,
                                                  id: $0.id
//												  ,
//                                                  eq: cells.eq
							)
                        }
                    } else {
                        return cells.list.map {
                            ReusableCellComponent(model: $0.model, reusableCell: ReusableCell(cells: cells), isReusable: false, id: $0.id
//												  , eq: cells.eq
							)
                        }
                    }
                }

                let flattenSections = sections.flatMap { $0 }

                let cellsBySection = flattenSections.map { section in
                    let list = section.cells
                    let cells = list.flatMap(cellsToReusableComponents)
                    return (section: section, cells: cells)
                }


                let carbonSections = cellsBySection.map { section, cells -> Carbon.Section in
                    return Carbon.Section(
                        id: section.id,
                        header: section.header.map { ViewNode($0) },
//                        cells: [],
                        cells: cells.map { CellNode($0) },
                        footer: section.footer.map { ViewNode($0) }
                    )
                }

                //                DispatchQueue.main.async {
                renderer.updater.isAnimationEnabled = !isFirstRender
                isFirstRender = false

                renderer.render(
                    carbonSections
                )



//                renderer.adapter.didSelect = { context in
//                    let cell = cellsBySection[context.indexPath.section].cells[context.indexPath.row]
//                    
//                    cell.selection(cell.model, context.indexPath)
//                }
//            }

            }.store(in: self.cb.asBag)

    }



//    public convenience init<O: Publisher, Adapter: UITableViewAdapter>(
//        _ observableList: O,
//        adapter: Adapter = UITableViewAdapter(),
//        updater: UITableViewUpdater<Adapter> = UITableViewUpdater(),
//        @ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//    ) where O.Output == [AnySection]
//    {
//        let adapter = adapter
//        self.init(frame: .zero)
//        self.backgroundColor = .clear
//
//        let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
//
//        let renderer = Renderer(
//            adapter: adapter,
//            updater: updater
//        )
//
//        renderer.target = self
//
//
//        observableList.sink { sectionList in
//            //                guard didAppear else { return }
//            let sections = sectionList.map { section -> Carbon.Section in
//
//                let list = section.cells
//
//
//                let cells: [ReusableCellWrapper] = list.map {
//
//                    let reuseId = String(reflecting: type(of: $0))
//
//                    if let reusableCell = reusableCellsById[reuseId]?.first {
//                        print(String(reflecting: type(of: $0)))
//                        return ReusableCellWrapper(
//                            model: $0,
//                            reusableCell: reusableCell
//                        )
//                    } else {
//                        fatalError("Has no reusable cell for this model \(reuseId)")
//                    }
//
//                }
//
//
//                return Carbon.Section(
//                    id: section.id,
//                    header: section.header.map { ViewNode($0) },
//                    cells: cells.map(CellNode.init),
//                    footer: section.footer.map { ViewNode($0) }
//                )
//            }
//
//            renderer.render(
//                sections
//            )
//
//            renderer.adapter.didSelect = { context in
//                let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
//                let reuseId = String(reflecting: type(of: model))
//                reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
//            }
//
//
//        }.store(in: self.cb.asBag)
//
//    }
}

//open class TableView: UIView {
//
//	public convenience init<O: Publisher>(
//		_ observableList: O,
//		tableView: UITableView = DynamicTableView(),
//		adapter: UITableViewAdapter = UITableViewAdapter(),
//		insets: UIEdgeInsets = .zero,
//		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//	) where O.Output == [EquatableIdentifiable] {
//		
//		
//		@Rx var sections: [AnySection] = []
//		
//		self.init(
//			$sections,
//			tableView: tableView,
//			adapter: adapter,
//			insets: insets,
//			reusableCells: reusableCells
//		)
//		
//		observableList.map { list in [ AnySection(id: "0", cells: list) ] }.sink {
//			sections = $0
//		}.store(in: self.cb.asBag)
//		
//	}
//	
//	public init<O: Publisher>(
//		_ observableList: O,
//		tableView: UITableView = DynamicTableView(),
//		adapter: UITableViewAdapter = UITableViewAdapter(),
//		insets: UIEdgeInsets = .zero,
//		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//	) where O.Output == [AnySection]
//	{
//		self.tableView = tableView
//		self.adapter = adapter
//		tableView.backgroundColor = .clear
//		super.init(frame: .zero)
//		self.backgroundColor = .clear
//		
//		let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
//		
//		addSubview(tableView)
//        tableView.fillToSuperview(top: insets.top,
//                                  left: insets.left,
//                                  right: insets.right,
//                                  bottom: insets.bottom)
//
//
//        renderer.target = tableView
//
//
//            observableList.sink { [weak self] sectionList in
//                //                guard didAppear else { return }
//                let sections = sectionList.map { section -> Carbon.Section in
//
//                    let list = section.cells
//
//
//                    let cells: [ReusableCellWrapper] = list.map {
//
//                        let reuseId = String(reflecting: type(of: $0))
//
//                        if let reusableCell = reusableCellsById[reuseId]?.first {
//                            print(String(reflecting: type(of: $0)))
//                            return ReusableCellWrapper(
//                                model: $0,
//                                reusableCell: reusableCell
//                            )
//                        } else {
//                            fatalError("Has no reusable cell for this model \(reuseId)")
//                        }
//
//                    }
//
//
//                    return Carbon.Section(
//                        id: section.id,
//                        header: section.header.map { ViewNode($0) },
//                        cells: cells.map(CellNode.init),
//                        footer: section.footer.map { ViewNode($0) }
//                    )
//                }
//
//                self?.renderer.render(
//                    sections
//                )
//
//                self?.renderer.adapter.didSelect = { context in
//                    let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
//                    let reuseId = String(reflecting: type(of: model))
//                    reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
//                }
//
//
//            }.store(in: self.tableView.cb.asBag)
//
//	}
//	
//	
//	let renderer = Renderer(
//		adapter: UITableViewAdapter(),
//		updater: UITableViewUpdater()
//	)
//	let adapter: UITableViewAdapter
//
//	public let tableView: UITableView
//	
//	public required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}
//

//extension UICollectionView {
//
//    public convenience init<O: Publisher, Adapter: UICollectionViewAdapter>(
//        _ data: O,
//        layout: UICollectionViewLayout = UICollectionViewFlowLayout().with.estimatedItemSize[.wh(100, 100)],
//        adapter: Adapter = UICollectionViewAdapter(),
//        updater: UICollectionViewUpdater<Adapter> = UICollectionViewUpdater(),
//        @ArrayBuilder<UISection> cellSections: @escaping (O.Output) -> [UISection]
//    ) {
//        let adapter = adapter
//        self.init(layout)
//        self.backgroundColor = .clear
//
//        var reusableCellsById: [String: ReusableCell] = [:]
//
//        let renderer = Renderer(
//            adapter: adapter,
//            updater: updater
//        )
//
//        renderer.target = self
//
//
//        data.sink { data in
//
//            let sections = cellSections(data)
//
//
//
////            let reusables = sections
////                .flatMap { $0.cells }
//
//
//            func cellsToReusableCells(_ cells: any CellsProtocol) -> [ReusableCellComponent] {
//                let reuseId = cells.reuseIdentifier
//
//                let reusableCell = {
//                    if let cell = reusableCellsById[reuseId] {
//                        return cell
//                    } else {
//                        let new = ReusableCell(cells: cells)
//                        reusableCellsById[reuseId] = new
//                        return new
//                    }
//                }()
//
//                return cells.list.map {
//                    ReusableCellComponent(model: $0, reusableCell: reusableCell)
//                }
//            }
//
//            let cellsBySection = sections.map { section in
//                let list = section.cells
//                let cells = list.flatMap(cellsToReusableCells)
//                return cells
//            }
//
//            let carbonSections = sections.map { section -> Carbon.Section in
//                let list = section.cells
//                let cells = list.flatMap(cellsToReusableCells)
//
//                return Carbon.Section(
//                    id: section.id,
//                    header: section.header.map { ViewNode($0) },
//                    cells: cells.map(CellNode.init),
//                    footer: section.footer.map { ViewNode($0) }
//                )
//            }
//
//            renderer.render(
//                carbonSections
//            )
//
//            renderer.adapter.didSelect = { context in
//                let cell = cellsBySection[context.indexPath.section][context.indexPath.row]
//                cell.reusableCell.selection(cell.model, context.indexPath)
//            }
//
//        }.store(in: self.cb.asBag)
//
//    }
//
//
//
//    public convenience init<O: Publisher, Adapter: UICollectionViewAdapter>(
//        _ observableList: O,
//        layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
//        adapter: Adapter = UICollectionViewAdapter(),
//        updater: UICollectionViewUpdater<Adapter> = UICollectionViewUpdater(),
//        @ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//    ) where O.Output == [AnySection]
//    {
//        let adapter = adapter
//        self.init(layout)
//        self.backgroundColor = .clear
//
//        let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
//
//        let renderer = Renderer(
//            adapter: adapter,
//            updater: updater
//        )
//
//        renderer.target = self
//
//
//        observableList.sink { sectionList in
//            //                guard didAppear else { return }
//            let sections = sectionList.map { section -> Carbon.Section in
//
//                let list = section.cells
//
//
//                let cells: [ReusableCellComponent] = list.map {
//
//                    let reuseId = String(reflecting: type(of: $0))
//
//                    if let reusableCell = reusableCellsById[reuseId]?.first {
//                        print(String(reflecting: type(of: $0)))
//                        return ReusableCellComponent(
//                            model: $0,
//                            reusableCell: reusableCell
//                        )
//                    } else {
//                        fatalError("Has no reusable cell for this model \(reuseId)")
//                    }
//
//                }
//
//
//                return Carbon.Section(
//                    id: section.id,
//                    header: section.header.map { ViewNode($0) },
//                    cells: cells.map(CellNode.init),
//                    footer: section.footer.map { ViewNode($0) }
//                )
//            }
//
//            renderer.render(
//                sections
//            )
//
//            renderer.adapter.didSelect = { context in
//                let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
//                let reuseId = String(reflecting: type(of: model))
//                reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
//            }
//
//
//        }.store(in: self.cb.asBag)
//
//    }
//}


//open class CollectionView: UIView {
//	
//	public convenience init<O: Publisher>(
//		_ observableList: O,
//		collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
//		adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
//		insets: UIEdgeInsets = .zero,
//		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//	) where O.Output == [EquatableIdentifiable] {
//		
//		
//		@Rx var sections: [AnySection] = []
//		
//		self.init(
//			$sections,
//			collectionView: collectionView,
//			adapter: adapter,
//			insets: insets,
//			reusableCells: reusableCells
//		)
//		
//		observableList.map { list in [ AnySection(id: "0", cells: list) ] }.sink {
//			sections = $0
//		}.store(in: self.cb.asBag)
//		
//	}
//	
//	public init<O: Publisher>(
//		_ observableList: O,
//		collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
//		adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
//		insets: UIEdgeInsets = .zero,
//		@ArrayBuilder <ReusableCell> reusableCells: @escaping () -> [ReusableCell]
//	) where O.Output == [AnySection]
//	{
//		self.collectionView = collectionView
//		self.adapter = adapter
//		collectionView.backgroundColor = .clear
//		super.init(frame: .zero)
//		self.backgroundColor = .clear
//		
//		let reusableCellsById = Dictionary(grouping: reusableCells(), by: { $0.reuseId })
//		
//		addSubview(collectionView)
//		collectionView.fillToSuperview(top: insets.top,
//																	 left: insets.left,
//																	 right: insets.right,
//																	 bottom: insets.bottom)
//		observableList.sink { [weak self] sectionList in
//			let sections = sectionList.map { section -> Carbon.Section in
//				
//				let list = section.cells
//				
//				
//				let cells: [ReusableCellWrapper] = list.map {
//					
//					let reuseId = String(reflecting: type(of: $0))
//					
//					if let reusableCell = reusableCellsById[reuseId]?.first {
//						print(String(reflecting: type(of: $0)))
//						return ReusableCellWrapper(
//							model: $0,
//							reusableCell: reusableCell
//						)
//					} else {
//						fatalError("Has no reusable cell for this model \(reuseId)")
//					}
//					
//				}
//				
//				
//				return Carbon.Section(
//					id: section.id,
//					header: section.header.map { ViewNode($0) },
//					cells: cells.map(CellNode.init),
//					footer: section.footer.map { ViewNode($0) }
//				)
//			}
//			
//			self?.renderer.render(
//				sections
//			)
//			self?.renderer.adapter.didSelect = { context in
//				let model = sectionList[context.indexPath.section].cells[context.indexPath.row]
//				let reuseId = String(reflecting: type(of: model))
//				reusableCellsById[reuseId]?.first?.selection(model, context.indexPath)
//			}
//			
//		}.store(in: self.collectionView.cb.asBag)
//		
//		renderer.target = collectionView
//	}
//
//	public init<O: Publisher, Id: Hashable, Model: Equatable>(
//			_ observableList: O,
//			id: @escaping (Model) -> Id,
//			selection: ((Model) -> ())? = nil,
//			collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
//			adapter: UICollectionViewAdapter = CollectionViewFlowLayoutAdapter(),
//			size: ( (Model) -> CGSize?)? = nil,
//			insets: UIEdgeInsets = .zero,
//			cellConfig: @escaping (CellWrapper<Model, Id>) -> () = {_ in},
//			rxContentFrom: @escaping (Rx<Model>) -> UIView
//	) where O.Output == [Model]
//	{
//			self.collectionView = collectionView
//			self.adapter = adapter
//			collectionView.backgroundColor = .clear
//			super.init(frame: .zero)
//			self.backgroundColor = .clear
//
//			addSubview(collectionView)
//			collectionView.fillToSuperview(top: insets.top,
//																		 left: insets.left,
//																		 right: insets.right,
//																		 bottom: insets.bottom)
//			observableList.sink { [weak self] list in
//
//							let cells = list.map {
//									CellWrapper(
//											$0,
//											id: id,
//											size: size?($0),
//											rxContentFrom: rxContentFrom
//									)
//							}
//
//							cells.forEach(cellConfig)
//
//							self?.renderer.render(
//                                Carbon.Section(
//											id: "section",
//											cells: cells.map(CellNode.init)
//									)
//							)
//							if let selection = selection {
//									self?.renderer.adapter.didSelect = { context in
//											let model = list[context.indexPath.row]
//											selection(model)
//									}
//							}
//
//			}.store(in: self.collectionView.cb.asBag)
//
//			renderer.target = collectionView
//	}
//	
//	let adapter: UICollectionViewAdapter
//	
//	lazy var renderer = Renderer(
//		adapter: adapter,
//		updater: UICollectionViewUpdater()
//	)
//	
//	public let collectionView: UICollectionView
//	
//	required public  init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}

public struct AnySection {
	public let id: String
	public var header: ComponentWrapper? = nil
	public var footer: ComponentWrapper? = nil
	public var size: CGSize? = nil
	public var cells: [Any]

	public init(
	 id: String,
	 header: ComponentWrapper? = nil,
	 footer: ComponentWrapper? = nil,
	 size: CGSize? = nil,
	 cells: [Any]
	) {
		self.id = id
		self.header = header
		self.footer = footer
		self.size = size
		self.cells = cells
	}



}

public extension AnyUIView {
	public func component(size: CGSize? = nil) -> ComponentWrapper {
		ComponentWrapper(view: self.getView, size: size)
	}
}

public struct ComponentWrapper: Component {
	public func renderContent() -> UIView {
        UIView().apply {
            $0.backgroundColor = .clear
        }
	}
	
	public func render(in content: UIView) {
        content.subviews.forEach { $0.removeFromSuperview() }
        content.addSubview(view.fill())
	}
	
	public func layout(content: UIView, in container: UIView) {
		container.addSubviews(
            content.fill()
        )
//        container.fill()
	}
	
	public func referenceSize(in bounds: CGRect) -> CGSize? {
		 size
	}
	
	public typealias Content = UIView

	let view: UIView
	var size: CGSize? = nil

}


public class ReusableCell {
	let reuseId: String
	let type: Any.Type
	let size: CGSize?
	var viewMaker: ((Rx<Any>) -> UIView) = { _ in __}
	var selection: (Any, IndexPath)->()
    

    var cancelables: [AnyCancellable] = []

    public init<Model>(_ type: Model.Type, reuseId: String, size: CGSize? = nil, selection: ((Model, IndexPath)->())?,

                                              @Builder<UIView> view: @escaping (Rx<Model>) -> UIView) {


        ReusableCellsCount += 1
        print("ReusableCell INIT ++", "cnt: ", ReusableCellsCount)
		self.type = Model.self
        self.reuseId = reuseId
		print(reuseId)
		self.size = size
		self.selection = { item, ip in (item as? Model).map { selection?($0, ip) } }

		let viewMaker: ((Rx<Any>) -> UIView) = { [weak self]  rxAny in
            guard let self else { return UIView() }

			@Rx var model: Model = rxAny.wrappedValue as! Model
            if let data = rxAny.value as? Model {
                model = data
            }
			rxAny.sink {
				if let data = $0 as? Model {
					model = data
				}
            }.store(in: &self.cancelables)

			return view(_model)
		}
		self.viewMaker = viewMaker
	}


    convenience init<Cells: CellsProtocol>(cells: Cells) {
        self.init(Cells.T.self, 
                  reuseId: cells.reuseIdentifier ?? "",
                  selection: cells.selection,
                  view: cells.content)
    }

    deinit {
        ReusableCellsCount -= 1
        print("ReusableCell DEINIT --", ReusableCellsCount)

    }
}

var ReusableCellsCount = 0

func DSd() {
    VStack(content: {

    })
    .frame()
}


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
extension Bool: EquatableIdentifiable { }
extension CGFloat: EquatableIdentifiable { }


public struct Identified<T>: EquatableIdentifiable {
    public func isEquialTo(_ another: Any) -> Bool {
        eq(another)
    }
    
    public init(model: T, id: (T) -> AnyHashable, eq: ((_ another: T) -> Bool)? = nil) {
        self.model = model
        self.modelID = id(model)

        self.eq = { another in
            guard let another = another as? T else { return false }
            return eq?(another) ?? false
        }
    }

    public let model: T
    public let modelID: AnyHashable
    public let eq: (_ another: Any) -> Bool
}

public extension Equatable {
    func identified(id: (Self) -> AnyHashable, eq: ((_ another: Self) -> Bool)? = nil) -> Identified<Self> {
        Identified(model: self, id: id, eq: eq)
    }
}


public extension UITableView {
    var automaticEstimatedRowHeight: CGFloat {
        get {
            estimatedRowHeight
        }

        set {
            rowHeight = UITableView.automaticDimension
            estimatedRowHeight = newValue
        }
    }
}
