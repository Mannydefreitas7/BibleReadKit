// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BibleReadKit",
    platforms: [.iOS(.v14), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BibleReadKit",
            targets: ["BibleReadKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.3"),
        .package(url: "https://github.com/realm/realm-swift.git",.upToNextMajor(from: "10.31.0"))
    ],
    targets: [
        .target(
            name: "BibleReadKit",
            dependencies: [
                .product(name: "SwiftSoup", package: "SwiftSoup"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ]),
        .testTarget(
            name: "BibleReadKitTests",
            dependencies: ["BibleReadKit"]),
    ]
)
