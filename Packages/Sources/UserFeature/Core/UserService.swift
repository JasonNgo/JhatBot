//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-22.
//

import SharedModels
import Foundation

public struct UserService: Sendable {
    public var saveUser: @Sendable (_ user: UserModel) async throws -> Void

    public var addUserListener: @Sendable (
        _ userId: String,
        _ onListenerAttached: (any NSObjectProtocol) -> Void
    ) -> AsyncThrowingStream<UserModel?, Error>
}
