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
        // Features
        .target(
            name: "AppFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "AuthenticationFeature",
                "ExploreFeature",
                "ChatFeature",
                "ProfileFeature",
                "AuthStore",
                "UserStore",
                "AvatarRepository"
            ],
            path: "Sources/Features/AppFeature"
        ),
        .target(
            name: "AuthenticationFeature",
            dependencies: [
                "Shared",
                "OnboardingFeature",
                "RegistrationFeature"
            ],
            path: "Sources/Features/AuthenticationFeature"
        ),
        .target(
            name: "OnboardingFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "UserStore"
            ],
            path: "Sources/Features/OnboardingFeature"
        ),
        .target(
            name: "ExploreFeature",
            dependencies: [
                "Shared",
                "SharedViews",
                "MessageFeature",
                "CategoryFeature"
            ],
            path: "Sources/Features/ExploreFeature"
        ),
        .target(
            name: "ChatFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews"
            ],
            path: "Sources/Features/ChatFeature"
        ),
        .target(
            name: "ProfileFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "RegistrationFeature",
                "CreateAvatarFeature",
                "AuthStore"
            ],
            path: "Sources/Features/ProfileFeature"
        ),
        .target(
            name: "RegistrationFeature",
            dependencies: [
                "SharedViews",
                "AuthStore",
                "UserStore"
            ],
            path: "Sources/Features/RegistrationFeature"
        ),
        .target(
            name: "CreateAvatarFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "AuthStore",
                "ImageGenerator",
                "ImageUploader",
                "AvatarRepository"
            ],
            path: "Sources/Features/CreateAvatarFeature"
        ),
        .target(
            name: "MessageFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "ChatFeature",
                "ProfileFeature"
            ],
            path: "Sources/Features/MessageFeature"
        ),
        .target(
            name: "CategoryFeature",
            dependencies: [
                "Shared",
                "SharedModels",
                "SharedViews",
                "AvatarRepository"
            ],
            path: "Sources/Features/CategoryFeature"
        ),

        // Repositories
        .target(
            name: "AvatarRepository",
            dependencies: [
                "Shared",
                "SharedModels",
                "ImageUploader",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
            ],
            path: "Sources/Repositories/AvatarRepository"
        ),
        .target(
            name: "UserStore",
            dependencies: [
                "Shared",
                "SharedModels",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
            ],
            path: "Sources/Stores/UserStore"
        ),

        // Services
        .target(
            name: "AuthStore",
            dependencies: [
                "SharedModels",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ],
            path: "Sources/Stores/AuthStore"
        ),
        .target(
            name: "ImageGenerator",
            dependencies: [
                .product(name: "OpenAI", package: "OpenAI")
            ],
            path: "Sources/Services/ImageGenerator"
        ),
        .target(
            name: "ImageUploader",
            dependencies: [
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk")
            ],
            path: "Sources/Services/ImageUploader"
        ),

        .target(name: "Shared", dependencies: []),
        .target(name: "SharedModels", dependencies: ["Shared"]),
        .target(name: "SharedViews", dependencies: [
            "Shared",
            .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
        ])
//        .testTarget(name: "AppFeatureTests", dependencies: []),
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
