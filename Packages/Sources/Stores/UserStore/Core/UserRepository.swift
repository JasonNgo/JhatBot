//
//  UserRepository.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-26.
//

import SharedModels
import Foundation

public struct UserRepository: Sendable {
    public var getUser: @Sendable (_ userId: String) -> UserModel?
    public var saveUser: @Sendable (_ user: UserModel) throws -> Void
    public var removeUser: @Sendable (_ userId: String) throws -> Void
}
