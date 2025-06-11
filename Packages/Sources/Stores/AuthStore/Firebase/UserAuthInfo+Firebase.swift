//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import SharedModels
import Foundation
import FirebaseAuth

extension UserAuthInfo {
    public static func makeFromUser(_ user: User) -> UserAuthInfo {
        .init(
            uid: user.uid,
            email: user.email,
            isAnonymous: user.isAnonymous,
            creationDate: user.metadata.creationDate,
            lastSignInDate: user.metadata.lastSignInDate
        )
    }
}
