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
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", exact: "3.1.3")
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "AuthenticationFeature"
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [

            ]
        ),
        .target(
            name: "AuthenticationFeature",
            dependencies: [
                "Shared",
                "OnboardingFeature"
            ]
        ),
        .target(
            name: "OnboardingFeature",
            dependencies: [
                "Shared"
            ]
        ),
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ]
        )
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
