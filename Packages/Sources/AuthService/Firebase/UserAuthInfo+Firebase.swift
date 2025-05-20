//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-12.
//

import Foundation
import FirebaseAuth

extension UserAuthInfo {
    public init(_ user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
