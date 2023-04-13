// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBLinterPlugin",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .plugin(
            name: "IBLinterPlugin",
            targets: ["IBLinterPlugin"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "IBLinterBinary",
            path: "IBLinter.artifactbundle.zip"
        ),
        .plugin(
            name: "IBLinterPlugin",
            capability: .buildTool(),
            dependencies: [
                "IBLinterBinary"
            ]
        ),
    ]
)
