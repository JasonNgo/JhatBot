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
                "AuthenticationFeature",
                "ExploreFeature",
                "ChatFeature",
                "ProfileFeature"
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
                "OnboardingFeature",
                "RegistrationFeature"
            ]
        ),
        .target(
            name: "OnboardingFeature",
            dependencies: [
                "Shared"
            ]
        ),
        .target(
            name: "ExploreFeature",
            dependencies: [
                "Shared",
                "AvatarModule",
                "MessageFeature",
                "CategoryFeature"
            ]
        ),
        .target(
            name: "AvatarModule",
            dependencies: [
                "Shared"
            ]
        ),
        .target(
            name: "ChatFeature",
            dependencies: [
                "Shared",
                "AvatarModule"
            ]
        ),
        .target(
            name: "ProfileFeature",
            dependencies: [
                "Shared",
                "AvatarModule",
                "RegistrationFeature",
                "CreateAvatarFeature"
            ]
        ),
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ]
        ),
        .target(
            name: "RegistrationFeature",
            dependencies: []
        ),
        .target(
            name: "CreateAvatarFeature",
            dependencies: [
                "Shared",
                "AvatarModule"
            ]
        ),
        .target(
            name: "MessageFeature",
            dependencies: [
                "Shared",
                "ChatFeature",
                "ProfileFeature"
            ]
        ),
        .target(
            name: "CategoryFeature",
            dependencies: [
                "Shared",
                "AvatarModule"
            ]
        )
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
