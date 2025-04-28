//
//  AppView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import AuthenticationFeature
import SwiftUI

public struct AppView: View {

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
    }

    // MARK: - Properties

    @State private var appState: AppState

    // MARK: - Initializers

    public init(appState: AppState = AppState()) {
        self.appState = appState
    }

}

// MARK: - Previews

#Preview("AppView - Authenticated") {
    AppView(appState: AppState(isAuthenticated: true))
}

#Preview("AppView - Unauthenticated") {
    AppView(appState: AppState(isAuthenticated: false))
}
