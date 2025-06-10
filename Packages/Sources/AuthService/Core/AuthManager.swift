//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-20.
//

import SharedModels
import Foundation
import Observation

@MainActor
@Observable
public class AuthManager {

    // MARK: - Properties

    public private(set) var auth: UserAuthInfo?
    private var listener: (any NSObjectProtocol)?

    // MARK: - Dependencies

    private let service: AuthService

    // MARK: - Initializers

    public init(service: AuthService) {
        self.service = service
        self.auth = service.getAuthenticatedUser()
        self.setupAuthListener()
    }

    private func setupAuthListener() {
        Task {
            for await value in service.addAuthenticatedUserListener({ listener in
                self.listener = listener
            }) {
                self.auth = value
                print("Auth listener success: \(value?.uid ?? "no uid")")
            }
        }
    }

    public func getAuthId() throws -> String {
        guard let id = auth?.uid else {
            throw AuthManagerError.notSignedIn
        }

        return id
    }

    public func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInAnonymously()
    }

    public func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInWithApple()
    }

    public func signOut() async throws {
        try await service.signOut()
        auth = nil
    }

    public func deleteAccount() async throws {
        try await service.deleteAccount()
        auth = nil
    }

}
