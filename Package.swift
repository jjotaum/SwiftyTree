// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyTree",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "SwiftyTree", targets: ["SwiftyTree"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "SwiftyTree",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .testTarget(
            name: "SwiftyTreeTests",
            dependencies: ["SwiftyTree"])
    ]
)
