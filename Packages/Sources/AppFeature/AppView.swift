//
//  AppView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SharedModels
import AuthenticationFeature
import AuthService
import UserFeature
import SwiftUI

public struct AppView: View {

    // MARK: - Properties

    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @State private var appState: AppState

    // MARK: - Body

    public var body: some View {
        AppViewBuilder(
            isAuthenticated: appState.isAuthenticated,
            authenticatedContentView: {
                TabBarView()
            },
            unauthenticatedContentView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .onChange(of: appState.isAuthenticated) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
        .task {
            await checkUserStatus()
        }
    }

    // MARK: - Initializers

    public init(appState: AppState = AppState()) {
        self.appState = appState
    }

    // MARK: - Actions

    private func checkUserStatus() async {
        if let user = authManager.auth {
            print("User already authenticated. User ID: \(user.uid)")

            do {
                try await userManager.login(auth: user, isNewUser: false)
            } catch {
                print("Failed to log in to auth for existing user: \(error)")
            }
        } else {
            do {
                let result = try await authManager.signInAnonymously()
                print("Sign in anonymously successful. User ID: \(result.user.uid)")

                try await userManager.login(auth: result.user, isNewUser: result.isNewUser)
            } catch {
                print(error)
            }
        }
    }

}

// MARK: - Previews

#Preview("AppView - Authenticated") {
    AppView(appState: AppState(isAuthenticated: true))
}

#Preview("AppView - Unauthenticated") {
    AppView(appState: AppState(isAuthenticated: false))
}
