//
//  UserModel.swift
//  Main
//
//  Created by Jason Ngo on 2025-04-28.
//

import Foundation

public struct UserModel: Codable, Sendable {
    public let userId: String
    public let email: String?
    public let isAnonymous: Bool
    public let creationDate: Date?
    public let creationVersion: String?
    public let lastSignInDate: Date?
    public let didCompleteOnboarding: Bool?
    public let profileColorHex: String?

    public init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool = true,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }

    public enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }
}

extension UserModel {
    public init(auth: UserAuthInfo, creationVersion: String?) {
        self.userId = auth.uid
        self.email = auth.email
        self.isAnonymous = auth.isAnonymous
        self.creationDate = auth.creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = auth.lastSignInDate
        self.didCompleteOnboarding = nil
        self.profileColorHex = nil
    }
}

#if canImport(SwiftUI) && canImport(Shared)
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
            isAnonymous: true,
            creationDate: Date(timeIntervalSince1970: 1_687_000_000),
            didCompleteOnboarding: true,
            profileColorHex: "#FF5733"
        ),
        UserModel(
            userId: "user_002",
            isAnonymous: true,
            creationDate: Date(timeIntervalSince1970: 1_687_100_000),
            didCompleteOnboarding: false,
            profileColorHex: "#33C1FF"
        ),
        UserModel(
            userId: "user_003",
            isAnonymous: true,
            creationDate: nil,
            didCompleteOnboarding: nil,
            profileColorHex: "#8E44AD"
        ),
        UserModel(
            userId: "user_004",
            isAnonymous: true,
            creationDate: Date(timeIntervalSince1970: 1_687_200_000),
            didCompleteOnboarding: true,
            profileColorHex: nil
        )
    ]}
}
