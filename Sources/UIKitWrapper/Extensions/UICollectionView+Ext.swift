//
//  UICollectionView+Ext.swift
//  StoriesLMS
//
//  Created by Zaur Kasaev on 05.03.2021.
//

import UIKit

public extension UICollectionView {
    
    // swiftlint:disable force_cast
    func dqReusableItemRegistration<T: UICollectionViewCell>(type: T.Type,
                                                             indexPath: IndexPath,
                                                             reuseID: String? = nil) -> T {
        let identifier = reuseID ?? String(describing: T.self)
        if cellForItem(at: indexPath) == nil {
            register(
                type,
                forCellWithReuseIdentifier: identifier)
            return dequeueReusableCell(withReuseIdentifier: identifier,
                                       for: indexPath) as! T
        } else {
            return dequeueReusableCell(withReuseIdentifier: identifier,
                                       for: indexPath) as! T
        }
    }
    // swiftlint:enable force_cast
}
