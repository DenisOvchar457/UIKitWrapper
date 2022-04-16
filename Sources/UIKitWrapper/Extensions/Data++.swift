//
//  Date++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 05.05.2021.
//

import Foundation
public extension Data {
    func htmlToAttrString() -> NSAttributedString {
        do {
            return try NSAttributedString(data: self,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
