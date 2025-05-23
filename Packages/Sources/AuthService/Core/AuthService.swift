//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import SharedModels
import Foundation

public struct AuthService: Sendable {
    public var getAuthenticatedUser: @Sendable () -> UserAuthInfo?
    public var signInAnonymously: @Sendable () async throws -> (user: UserAuthInfo, isNewUser: Bool)
    public var signInWithApple: @Sendable () async throws -> (user: UserAuthInfo, isNewUser: Bool)
    public var signOut: @Sendable () async throws -> Void
    public var deleteAccount: @Sendable () async throws -> Void

    public var addAuthenticatedUserListener: @Sendable (
        _ onListenerAttached: (any NSObjectProtocol) -> Void
    ) -> AsyncStream<UserAuthInfo?>
}

#if canImport(SwiftUI)

import SwiftUI

public extension EnvironmentValues {
    @Entry var authService: AuthService = .mockWithUser
}

#endif
