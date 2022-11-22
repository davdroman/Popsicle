// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Popsicle",
    platforms: [
        .iOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v11),
    ],
    products: [
        .library(name: "Popsicle", targets: ["Popsicle"]),
    ],
    targets: [
        .target(
            name: "Popsicle",
            dependencies: [
                .product(name: "SortedCollections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "PopsicleTests",
            dependencies: [
                "Popsicle",
            ]
        ),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/apple/swift-collections", branch: "main"),
]
