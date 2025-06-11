//
//  AppView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SharedModels
import AuthenticationFeature
import AuthStore
import UserStore
import SwiftUI

public struct AppView: View {

    // MARK: - Properties

    @Environment(AuthStore.self) private var authStore
    @Environment(UserStore.self) private var userStore
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
        if let user = authStore.auth {
            print("User already authenticated. User ID: \(user.uid)")

            do {
                try await userStore.login(auth: user, isNewUser: false)
            } catch {
                print("Failed to log in to auth for existing user: \(error)")
            }
        } else {
            do {
                let result = try await authStore.signInAnonymously()
                print("Sign in anonymously successful. User ID: \(result.user.uid)")

                try await userStore.login(auth: result.user, isNewUser: result.isNewUser)
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
