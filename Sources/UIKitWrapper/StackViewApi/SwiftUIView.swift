//
//  SwiftUIView.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import UIKit
import SwiftUI

private let previewDeviceName = //"iPhone 12"//
	"iPad 2 (com.apple.CoreSimulator.SimDeviceType.iPad-2)"

@available(iOS 13.0, *)
public struct ContentView : View {
    public var view: UIView

    public var body: some View {
        UIWrapper(view: view)
    }
}


public struct UIWrapper: UIViewRepresentable {
    public func updateUIView(_ uiView: UIView, context: Context) {}
    let view: UIView
    public typealias UIViewType = UIView

    public func makeUIView(context: Self.Context) -> UIView {
        view
    }
}

@available(iOS 13.0, *)
public struct SwiftUIView: View {
    let view: UIView
    public var body: some View {
        ContentView( view: view)
        .previewDevice(PreviewDevice(rawValue: previewDeviceName))
        .previewDisplayName(previewDeviceName)
        .previewLayout(.fixed(width: 1366, height: 1024))
    }

    public init(_ view: UIView) {
        self.view = view
    }
}

public extension UIView {
    var swiftUI: SwiftUIView {
        SwiftUIView(self)
    }
}
