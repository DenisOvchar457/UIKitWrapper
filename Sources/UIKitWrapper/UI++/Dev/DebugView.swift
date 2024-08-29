//
//  DebugView.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//

import UIKit
import UIKitWrapper


public class DebugArcView: UIView {
//    let imgView = UIImageView()
    static var cnt = 0

    public var onDeinit: (()->())?
    public let name: String

    public init(name: String = #function) {
        self.name = name
        super.init(frame: .zero)
//        addSubviewAutoresizing(imgView)
        DebugArcView.cnt+=1
        print("DebugArcView Init ", name , " count:  ", DebugArcView.cnt)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        DebugArcView.cnt += -1
        print(name," DebugArcView DEINIT", name, " count:  ", DebugArcView.cnt )
        onDeinit?()
    }
}
//private var cnt = 0


public class DebugTableView: UITableView {
    //    let imgView = UIImageView()
    static var cnt = 0


    public let name: String = ""


    deinit {
//        DebugTableView.cnt += -1
        print(name," DebugTableView DEINIT" )
    }
}
