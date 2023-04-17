// swift-tools-version: 5.5
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
            name: "iblinter",
            url: "https://github.com/nnsnodnb/iblinter-plugin/releases/download/0.5.0/IBLinter.artifactbundle.zip",
            checksum: "bbda7a1f3966636428f70f50da4327cafa32c0276f4c6081cfae9f3c6731cc2b"
        ),
        .plugin(
            name: "IBLinterPlugin",
            capability: .buildTool(),
            dependencies: [
                "iblinter"
            ]
        ),
    ]
)
