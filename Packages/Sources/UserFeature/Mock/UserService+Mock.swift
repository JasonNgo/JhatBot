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
        getUser: { userId in
            guard let user else {
                throw UserServiceError.noData
            }

            return user
        },
        saveUser: { user in

        },
        deleteUser: { userId in

        },
        updateUser: { userId, updates in

        },
        addUserListener: { userId, onListenerAttached in
            AsyncThrowingStream { continuation in
                if let currentUser = user {
                    continuation.yield(currentUser)
                }
            }
        },
        removeUserListener: { listener in

        }
    )}
}
