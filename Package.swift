// swift-tools-version:5.1

// ImageZoom plugin for Publish
// Copyright (c) Mark Battistella 2022
// MIT license - see LICENSE for details

import PackageDescription

let package = Package(
	name: "ImageZoom",
	products: [
		.library(
			name: "ImageZoom",
			targets: ["ImageZoom"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
	],
	targets: [
		.target(
			name: "ImageZoom",
			dependencies: ["Publish"]
		)
	]
)
