//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-23.
//

import SharedModels
import Foundation

public extension UserService {
    static func mock(user: UserModel?) -> Self {.init(
        getUser: { _ in
            guard let user else {
                throw UserServiceError.noData
            }

            return user
        },
        saveUser: { _ in

        },
        deleteUser: { _ in

        },
        updateUser: { _, _ in

        },
        addUserListener: { _, _ in
            AsyncThrowingStream { continuation in
                if let currentUser = user {
                    continuation.yield(currentUser)
                }
            }
        },
        removeUserListener: { _ in

        }
    )}
}
