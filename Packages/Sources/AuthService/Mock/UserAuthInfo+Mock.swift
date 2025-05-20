//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-20.
//

import Foundation

public extension UserAuthInfo {
    static func mock(isAnonymous: Bool = false) -> Self {
        UserAuthInfo(
            uid: "mock_user_123456789",
            email: "jasonnngo@gmail.com",
            isAnonymous: isAnonymous,
            creationDate: .now,
            lastSignInDate: .now
        )
    }
}
