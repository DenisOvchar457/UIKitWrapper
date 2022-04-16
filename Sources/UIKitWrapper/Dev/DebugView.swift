//
//  DebugView.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//

import UIKit
import UIKitWrapper


class DebugArcView: UIView {
//    let imgView = UIImageView()
   
    var onDeinit: (()->())?
    let name: String
    
    init(name: String = #function) {
        self.name = name
        super.init(frame: .zero)
//        addSubviewAutoresizing(imgView)
        print("myVIew Init ", cnt)
        cnt+=1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print(name," DEINIT")
        cnt += -1
        onDeinit?()
    }
}
private var cnt = 0
