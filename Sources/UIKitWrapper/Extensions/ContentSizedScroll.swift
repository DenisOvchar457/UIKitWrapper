//
//  ContentSizedScroll.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import UIKit
final public class ContentSizedTableView: UITableView {
	public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

	public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

final public class ContentSizedScrollView: UIScrollView {
	public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

	public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

