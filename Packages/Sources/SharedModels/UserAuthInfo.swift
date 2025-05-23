//
//  UserAuthInfo.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import Foundation

public struct UserAuthInfo: Sendable {
    public let uid: String
    public let email: String?
    public let isAnonymous: Bool
    public let creationDate: Date?
    public let lastSignInDate: Date?

    public init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = true,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
}
