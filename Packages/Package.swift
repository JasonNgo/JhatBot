// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Main",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .singleTargetLibrary("AppFeature")
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "Shared"
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [

            ]
        ),
        .target(
            name: "Shared",
            dependencies: [

            ]
        )
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
