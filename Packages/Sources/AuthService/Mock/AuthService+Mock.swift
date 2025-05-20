//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-20.
//

import Foundation

public extension AuthService {
    static let mockWithAnonymousUser = Self(
        getAuthenticatedUser: {
            UserAuthInfo.mock(isAnonymous: true)
        },
        signInAnonymously: {
            (UserAuthInfo.mock(isAnonymous: true), true)
        },
        signInWithApple: {
            (UserAuthInfo.mock(), false)
        },
        signOut: {

        },
        deleteAccount: {

        },
        addAuthenticatedUserListener: { onListenerAttached in
            AsyncStream { continuation in
                continuation.yield(UserAuthInfo.mock(isAnonymous: true))
            }
        }
    )

    static let mockWithUser = Self(
        getAuthenticatedUser: {
            UserAuthInfo.mock()
        },
        signInAnonymously: {
            (UserAuthInfo.mock(isAnonymous: true), true)
        },
        signInWithApple: {
            (UserAuthInfo.mock(), false)
        },
        signOut: {

        },
        deleteAccount: {

        },
        addAuthenticatedUserListener: { onListenerAttached in
            AsyncStream { continuation in
                continuation.yield(UserAuthInfo.mock())
            }
        }
    )

    static let mockWithoutUser = Self(
        getAuthenticatedUser: {
            nil
        },
        signInAnonymously: {
            (UserAuthInfo.mock(isAnonymous: true), true)
        },
        signInWithApple: {
            (UserAuthInfo.mock(), false)
        },
        signOut: {

        },
        deleteAccount: {

        },
        addAuthenticatedUserListener: { onListenerAttached in
            AsyncStream { continuation in
                continuation.yield(nil)
            }
        }
    )
}
