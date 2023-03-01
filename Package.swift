// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWCheckBox",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "WWCheckBox", targets: ["WWCheckBox"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "WWCheckBox", resources: [.process("Xib")]),
    ], swiftLanguageVersions: [
        .v5
    ]
)
