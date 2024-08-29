//
//  SwiftUIView.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 13.04.2021.
//

import UIKit
import SwiftUI

public var previewDeviceName: String = //"iPhone 12"//
	"iPad 2 (com.apple.CoreSimulator.SimDeviceType.iPad-2)"
public var previewSize: CGSize = CGSize()


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
        ContentView(view: view)
        .previewDevice(PreviewDevice(rawValue: previewDeviceName))
        .previewDisplayName(previewDeviceName)
				.previewLayout(.fixed(width: previewSize.width, height: previewSize.height))
//				.landscape()
		}

    public init(_ view: UIView) {
        self.view = view
    }
}

struct LandscapeModifier: ViewModifier {
		func body(content: Content) -> some View {
				content
						.previewLayout(.fixed(width: 812, height: 375))
						.environment(\.horizontalSizeClass, .compact)
						.environment(\.verticalSizeClass, .compact)
		}
}

extension View {
		func landscape() -> some View {
				self.modifier(LandscapeModifier())
		}
}

public extension UIView {
    var swiftUI: SwiftUIView {
        SwiftUIView(self)
    }
}
