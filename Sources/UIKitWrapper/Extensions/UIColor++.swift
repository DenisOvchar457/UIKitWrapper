//
//  UIColor+extension.swift
//  StoriesLMS
//
//  Created by Olga Dakhel on 20.02.2021.
//

import UIKit

public extension UIColor {

    static func hex(_ hexString: String) -> UIColor {

        var hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.remove(at: hexString.startIndex) }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        return .init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
