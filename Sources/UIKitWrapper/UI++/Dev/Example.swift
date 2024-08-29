//
//  Example.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import SwiftUI
import UIKit
import FoundationExtensions

class ExampleVC: VC<()> {
    
    @Rx var isMenuShown: Bool = false
    
    override var content: UIView {
        Z(
            V(
                __,
                15,

                "Wake up stranger...".textColor(.systemGreen).label()~
                    .font[.boldSystemFont(ofSize: 25)],

                10,

                Attr {
                    "Apple"
                    "has you"
                    " attributed texts".underline().textColor(.systemBlue)
//                    (
//                        "\n they are stack items".textColor(.yellow).font(.systemFont(ofSize: 17, weight: .medium))
//                        +
//                        " too".font(.boldSystemFont(ofSize: 20))
//                    ).textColor(.yellow)
                }
//                    .font(.systemFont(ofSize: 17, weight: .medium))
                    .label(lines: 0)
                    .left(20).right(20),

                30,
//                ,

                circle(color: UIColor.green, rad: 70),

                circle(color: UIColor.red, rad: 100),

                20,

                UIView()[width: 100, height: 100].apply {
                    $0.lines(color: .rgb(218, 85, 48), fillColor: .yellow, width: 1,
                             xy(0,0),
                             xy(100, 20),
                             xy(-100, 20),
                             xy(0, -40))
                },

                __
            ).with.backgroundColor[.systemGray6]
                .alignment[.center]
                .radius[20]
                .centerX(0)
                .paddings(20,
                         (nil, 20),
                         nil)
        )~.backgroundColor[.systemBackground]
            .uiStyle[.dark]

    }
    
     func circle(color: UIColor, rad: CGFloat) -> UIView {
        UIView().width(rad*2).height(rad*2)~
            .radius[rad]
            .backgroundColor[color]

    }
    
    func tap() {
        
    }
    
    
}

struct ExampleVCPreview_Previews: PreviewProvider {
    static var previews: some View {
        ExampleVC(()).view.fill().swiftUI
    }
}
