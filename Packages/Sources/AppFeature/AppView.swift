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
import SwiftUI

public struct AppView: View {

    // MARK: - Properties

    @Environment(\.authService) private var authService
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
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.isAuthenticated) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }

    // MARK: - Initializers

    public init(appState: AppState = AppState()) {
        self.appState = appState
    }

    // MARK: - Actions

    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            print("User already authenticated. User ID: \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnonymously()
                print("Sign in anonymously successful. User ID: \(result.user.uid)")
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
