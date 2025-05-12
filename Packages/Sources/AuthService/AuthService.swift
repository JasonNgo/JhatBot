//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import Foundation

public struct AuthService: Sendable {
    public var getAuthenticatedUser: @Sendable () -> UserAuthInfo?
    public var signInAnonymously: @Sendable () async throws -> (user: UserAuthInfo, isNewUser: Bool)
}

