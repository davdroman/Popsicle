// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Popsicle",
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
        .testTarget(name: "PopsicleTests", dependencies: ["Popsicle"]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.3"),
]
