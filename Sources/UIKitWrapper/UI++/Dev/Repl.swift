//
//  Repl.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//

import UIKit

func repl(_ values: Any...) -> UIView {
    VScroll(
        34,
        values
            .map { String(describing: $0) }
            .vStack(separator: __[color: #colorLiteral(red: 0.4561609626, green: 0.0038283139, blue: 1, alpha: 0.5219245158), height: 1].wrappedInContainer().left(0).right(0)) {
                $0.label(textColor: #colorLiteral(red: 0, green: 1, blue: 0.5372107029, alpha: 1), font: .systemFont(ofSize: 15), lines: 0).wrappedInContainer().left(30)
            },
        __
    )[color: #colorLiteral(red: 0.001679527457, green: 0.06034138799, blue: 0.1765818894, alpha: 1)]
}
