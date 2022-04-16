//
//  UIScrollView++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//

import UIKit

public extension UIScrollView {
    func scrollSubviewToBeVisible(subview: UIView, insets: UIEdgeInsets , animated: Bool) {

        DispatchQueue.main.async {
            self.setContentOffset(self.contentOffset, animated:false)

            self.layer.removeAllAnimations()
        UIView.animate(0.3) {
            let visibleFrame = self.bounds.inset(by: self.contentInset)
            let subviewFrame = subview.convert(subview.bounds, to: self).inset(by: .init(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right))
            if (!visibleFrame.contains(subviewFrame)) {
                self.scrollRectToVisible(subviewFrame, animated: false)
            }
        }
        }
    }
}
