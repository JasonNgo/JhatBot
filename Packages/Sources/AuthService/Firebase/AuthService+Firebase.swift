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
            return result.asAuthInfo
        },
        signInWithApple: {
            let helper = SignInWithAppleHelper()
            let response = try await helper.signIn()

            let provider = OAuthProvider.credential(
                providerID: AuthProviderID.apple,
                idToken: response.token,
                rawNonce: response.nonce
            )

            // try to link existing anonymous user
            if let user = Auth.auth().currentUser, user.isAnonymous {
                do {
                    try await user.link(with: provider)
                } catch let error as NSError {
                    let authError = AuthErrorCode(rawValue: error.code)

                    switch authError {
                    case .providerAlreadyLinked, .credentialAlreadyInUse:
                        if let updatedProvider = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                            let result = try await Auth.auth().signIn(with: updatedProvider)
                            return result.asAuthInfo
                        }
                    default:
                        break
                    }
                }
            }

            // otherwise sign in with new account
            let result = try await Auth.auth().signIn(with: provider)
            return result.asAuthInfo
        },
        signOut: {
            try Auth.auth().signOut()
        },
        deleteAccount: {
            guard let user = Auth.auth().currentUser else {
                throw AuthServiceError.userNotFound
            }

            try await user.delete()
        }
    )
}

fileprivate extension AuthDataResult {
    var asAuthInfo: (UserAuthInfo, Bool) {
        let userAuthResult = UserAuthInfo(user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (userAuthResult, isNewUser)
    }
}
