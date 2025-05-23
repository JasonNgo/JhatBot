//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-22.
//

import Shared
import SharedModels
import Foundation
import Observation

@MainActor
@Observable
public class UserManager {

    // MARK: - Properties

    public private(set) var currentUser: UserModel?

    // MARK: - Dependencies

    private let service: UserService

    // MARK: - Initializers

    public init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }

    // MARK: - Listener

    private func setupUserListener() {
        
    }

    // MARK: -

    public func login(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)

        try await service.saveUser(user)
    }


}
