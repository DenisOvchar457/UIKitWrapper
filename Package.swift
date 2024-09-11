// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitWrapper",
		platforms: [
			.iOS(.v13)
            
		],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UIKitWrapper",
            targets: ["UIKitWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/HyperfocusDisordered/FoundationExtensions.git", .exact("2.0.2")),
        .package(url: "https://github.com/HyperfocusDisordered/CombineOperators.git", .exact("2.0.5")),
//			.package(name: "Nuke", url: "https://github.com/kean/Nuke", from: "10.7.1"),
        .package(name: "InputMask", url: "https://github.com/RedMadRobot/input-mask-ios", .exact("6.1.0")),
			.package(name: "Carbon", url: "https://github.com/ra1028/Carbon", revision: "56e5f29fc42cad4b0d27b97dccd4065297267ac5"),
        .package(name: "VDCodable", url: "https://github.com/dankinsoid/VDCodable.git", .exact("2.13.0")),
		],
    targets: [
        .target(
            name: "UIKitWrapper",
						dependencies: ["CombineOperators", "InputMask", "VDCodable", "Carbon", "FoundationExtensions"]),
//        .testTarget(
//            name: "UIKitWrapperTests",
//            dependencies: ["UIKitWrapper"]),
    ]
)
