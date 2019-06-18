// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
	name: "Popsicle",
	products: [
		.library(name: "Popsicle", targets: ["Popsicle"]),
	],
	dependencies: [],
	targets: [
		.target(name: "Popsicle", dependencies: []),
		.testTarget(name: "PopsicleTests", dependencies: ["Popsicle"]),
	]
)
