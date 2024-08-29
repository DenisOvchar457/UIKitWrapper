//
//  UIScrollView++.swift
//  MusicImport
//
//  Created by crypto_user on 20.02.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

#if canImport(UIKit) && os(iOS)
import UIKit

extension UIScrollView {
	
	public var contentEdge: UIEdgeInsets {
		UIEdgeInsets(
			top: -contentOffset.y - adjustedContentInset.top,
			left: -contentOffset.x - adjustedContentInset.left,
			bottom: frame.height + contentOffset.y - contentSize.height - adjustedContentInset.bottom,
			right: frame.width + contentOffset.x - contentSize.width - adjustedContentInset.right
		)
	}
	
	public var bounceEdge: UIEdgeInsets {
		UIEdgeInsets(
			top: -contentOffset.y - adjustedContentInset.top,
			left: -contentOffset.x - adjustedContentInset.left,
			bottom: contentOffset.y + adjustedContentInset.top + min(0, frame.height - contentSize.height - adjustedContentInset.bottom - adjustedContentInset.top),
			right: contentOffset.x + adjustedContentInset.left + min(0, frame.width - contentSize.width - adjustedContentInset.right - adjustedContentInset.left)
		)
	}
	
	public var adjustedSize: CGSize {
		CGSize(
			width: frame.width - adjustedContentInset.left - adjustedContentInset.right,
			height: frame.height - adjustedContentInset.top - adjustedContentInset.bottom
		)
	}
}

extension UIEdgeInsets {
	public init(_ top: CGFloat,
							_ h: (CGFloat, CGFloat),
							_ bottom: CGFloat) {
		self = UIEdgeInsets(top: top, left: h.0, bottom: bottom, right: h.1)
	}
}

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


extension UIScrollView {
    var adjustedOffset: CGPoint {
        contentOffset
            .x(-adjustedContentInset.left)
            .y(-adjustedContentInset.top)

    }
}

#endif
