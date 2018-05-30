// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "OrderedDictionary",
    products: [
        .library(name: "OrderedDictionary", targets: ["OrderedDictionary"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OrderedDictionary",
            path: "./Sources"
        ),
        .testTarget(
            name: "OrderedDictionaryTests",
            dependencies: ["OrderedDictionary"],
            path: "./Tests"
        ),
    ]
)
