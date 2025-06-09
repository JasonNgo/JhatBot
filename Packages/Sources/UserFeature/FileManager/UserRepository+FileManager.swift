//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-26.
//

import Foundation

extension UserRepository {
    static public let fileManager = Self(
        getUser: { userId in
            FileManager.default.getDocument(key: userId)
        },
        saveUser: { user in
            try FileManager.default.saveDocument(key: user.userId, value: user)
        },
        removeUser: { userId in
            try FileManager.default.removeDocument(key: userId)
        },
        getCurrentUser: {
            FileManager.default.getDocument(key: "currentUser")
        }
    )
}
