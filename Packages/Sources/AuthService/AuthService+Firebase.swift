//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import Firebase
import FirebaseAuth
import Foundation

public extension AuthService {
    static let firebase = Self(
        getAuthenticatedUser: {
            if let user = Auth.auth().currentUser {
                return UserAuthInfo(user)
            } else {
                return nil
            }
        },
        signInAnonymously: {
            let result = try await Auth.auth().signInAnonymously()
            let userAuthResult = UserAuthInfo(result.user)
            let isNewUser = result.additionalUserInfo?.isNewUser ?? true

            return (userAuthResult, isNewUser)
        }
    )
}

fileprivate extension UserAuthInfo {
    init(_ user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
