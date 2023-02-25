// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFountainParser",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftFountainParser",
            targets: ["SwiftFountainParser"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-html", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftFountainParser",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Html", package: "swift-html")
            ],
            resources: [
                .process("static/screenplay.css")
            ]
        ),
        .testTarget(
            name: "SwiftFountainParserTests",
            dependencies: ["SwiftFountainParser"],
            resources: [
                .process("static/screenplay.css")
            ]
        ),
    ]
)
