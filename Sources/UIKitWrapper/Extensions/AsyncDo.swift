//
//  AsyncDo.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 14.06.2021.
//

import Foundation

public struct ErrorWrapper {
    let error: Error
}

public class AsyncDoResult {
    var isCatchInited = false {
        didSet {
            if isCatchInited {
                DispatchQueue.global().async {

                    do {
                        try self.block()
                    } catch {
                        self.errorHandler?(ErrorWrapper(error: error))
                    }
                }
            }
        }
    }
    let block: () throws -> ()
    
    init(block: @escaping () throws -> () ) {
        self.block = block
    }
    var errorHandler: ((ErrorWrapper) -> () )? = nil
    
    func `catch`(catchBlock: @escaping (ErrorWrapper) -> () ) {
        self.errorHandler = catchBlock
        isCatchInited = true
    }
}



func asyncDo(_ queue: DispatchQoS.QoSClass = .default, block: @escaping () throws -> () ) -> AsyncDoResult {
    return AsyncDoResult(block: block)
}
