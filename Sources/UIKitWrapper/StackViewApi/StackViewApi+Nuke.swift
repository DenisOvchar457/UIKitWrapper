//
//  StackViewApi+Nuke.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 07.06.2021.
//

import UIKit
import Nuke

public func Image(url: URLConvertable) -> UIImageView {
    UIImageView().apply {
        if let url = url.url {
            Nuke.loadImage(with: url.url, into: $0)
        }
    }
}
