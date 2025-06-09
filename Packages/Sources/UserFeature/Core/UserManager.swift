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
    // listener
    private var currentUserListener: (any NSObjectProtocol)?
    private var listenerTask: Task<Void, Never>?

    // MARK: - Computed

    private var currentUserId: String {
        get throws {
            guard let userId = currentUser?.userId else {
                throw UserManagerError.noUserId
            }

            return userId
        }
    }

    // MARK: - Dependencies

    private let remote: UserService
    private let local: UserRepository

    // MARK: - Initializers

    public init(service: UserService, local: UserRepository) {
        self.remote = service
        self.local = local
        self.currentUser = local.getUser("")
    }

    // MARK: - Listener

    public func configureUserListener(userId: String) {
        removeUserListener()
        
        self.listenerTask = Task {
            do {
                for try await value in remote.addUserListener(userId, { listener in
                    self.currentUserListener = listener
                }) {
                    self.currentUser = value
                    print("Successfully listened to user: \(value.userId)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }
    
    public func removeUserListener() {
        // Remove the actual listener
        if let listener = currentUserListener {
            remote.removeUserListener(listener)
            currentUserListener = nil
        }

        // Cancel the stream task
        listenerTask?.cancel()
        listenerTask = nil
    }

    // MARK: - Auth

    public func login(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)

        try await remote.saveUser(user)
        configureUserListener(userId: user.userId)
    }

    public func logout() {
        removeUserListener()
        currentUser = nil
    }

    // MARK: - Current User

    public func updateOnboardingStatusForCurrentUser(profileColorHex: String) async throws {
        let userId = try currentUserId

        try await remote.updateUser(userId, [
            UserModel.CodingKeys.didCompleteOnboarding.stringValue: true,
            UserModel.CodingKeys.profileColorHex.stringValue: profileColorHex
        ])
    }

    public func deleteCurrentUser() async throws {
        let userId = try currentUserId
        try await remote.deleteUser(userId)
        logout()
    }

}
