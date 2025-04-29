//
//  UserModel.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

public struct UserModel {
    public let userId: String
    public let dateCreated: Date?
    public let didCompleteOnboarding: Bool?
    public let profileColorHex: String?

    public init(
        userId: String,
        dateCreated: Date?,
        didCompleteOnboarding: Bool?,
        profileColorHex: String?
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
}

#if canImport(SwiftUI)
import SwiftUI

public extension UserModel {
    var profileColorCalculated: Color {
        guard let profileColorHex else {
            return Color.accentColor
        }

        return Color(hex: profileColorHex)
    }
}

#endif

// MARK: - Mocks

public extension UserModel {
    static var mock: Self { mocks[0] }

    static var mocks: [Self] {[
        UserModel(
            userId: "user_001",
            dateCreated: Date(timeIntervalSince1970: 1_687_000_000),
            didCompleteOnboarding: true,
            profileColorHex: "#FF5733"
        ),
        UserModel(
            userId: "user_002",
            dateCreated: Date(timeIntervalSince1970: 1_687_100_000),
            didCompleteOnboarding: false,
            profileColorHex: "#33C1FF"
        ),
        UserModel(
            userId: "user_003",
            dateCreated: nil,
            didCompleteOnboarding: nil,
            profileColorHex: "#8E44AD"
        ),
        UserModel(
            userId: "user_004",
            dateCreated: Date(timeIntervalSince1970: 1_687_200_000),
            didCompleteOnboarding: true,
            profileColorHex: nil
        )
    ]}
}
