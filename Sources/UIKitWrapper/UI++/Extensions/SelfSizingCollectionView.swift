//
//  SelfSizingCollectionView.swift
//  StoriesLMS
//
//  Created by Zaur Kasaev on 05.03.2021.
//

import Foundation

import UIKit

public class SelfSizingCollectionView: UICollectionView {
	public override func reloadData() {
        super.reloadData()
        layoutIfNeeded()
    }
    
	public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

	public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(
            width: collectionViewLayout.collectionViewContentSize.width,
            height: collectionViewLayout.collectionViewContentSize.height)
    }
}


open class SelfSizingTableView: UITableView {
//    open override func reloadData() {
//        super.reloadData()
//        layoutIfNeeded()
//    }

    open override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    public override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
