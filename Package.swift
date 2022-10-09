// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BibleReadKit",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BibleReadKit",
            targets: ["BibleReadKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.3"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git",.upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/realm/realm-swift.git",.upToNextMajor(from: "10.31.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BibleReadKit",
            dependencies: [

                .product(name: "SwiftSoup", package: "SwiftSoup"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestoreSwift", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ]),
        .testTarget(
            name: "BibleReadKitTests",
            dependencies: ["BibleReadKit"]),
    ]
)
