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
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", exact: "3.1.3"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.12.0"),
        .package(url: "https://github.com/MacPaw/OpenAI.git", exact: "0.4.3")
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "AuthenticationFeature",
                "ExploreFeature",
                "ChatFeature",
                "ProfileFeature",
                "AuthService",
                "UserFeature"
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
                "Shared",
                "SharedModels",
                "UserFeature"
            ]
        ),
        .target(
            name: "ExploreFeature",
            dependencies: [
                "Shared",
                "SharedViews",
                "MessageFeature",
                "CategoryFeature"
            ]
        ),
        .target(
            name: "ChatFeature",
            dependencies: [
                "Shared",
                "SharedModels"
            ]
        ),
        .target(
            name: "ProfileFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "RegistrationFeature",
                "CreateAvatarFeature",
                "AuthService"
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
            dependencies: [
                "SharedViews",
                "AuthService",
                "UserFeature"
            ]
        ),
        .target(
            name: "CreateAvatarFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "ImageProducerService"
            ]
        ),
        .target(
            name: "MessageFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "ChatFeature",
                "ProfileFeature"
            ]
        ),
        .target(
            name: "CategoryFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews"
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                "Shared"
            ]
        ),
        .target(name: "SharedViews", dependencies: [
            "Shared"
        ]),
        .target(name: "AuthService", dependencies: [
            .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            "SharedModels"
        ]),
        .target(name: "UserFeature", dependencies: [
            .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
            "Shared",
            "SharedModels"
        ]),
        .target(name: "ImageProducerService", dependencies: [
            .product(name: "OpenAI", package: "OpenAI")
        ])
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
