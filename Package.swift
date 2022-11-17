// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Popsicle",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "Popsicle", targets: ["Popsicle"]),
    ],
    targets: [
        .target(
            name: "Popsicle",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "PopsicleTests",
            dependencies: [
                "Popsicle",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.3"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),
]
