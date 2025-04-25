//
//  AppView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SwiftUI

public struct AppView: View {

    @State private var appState: AppState

    public init(appState: AppState = AppState()) {
        self.appState = appState
    }

    public var body: some View {
        AppViewBuilder(
            isAuthenticated: appState.isAuthenticated,
            authenticatedContentView: {
//                TabBarView()
                Text("World")
            },
            unauthenticatedContentView: {
                Text("Hello")
//                WelcomeView()
            }
        )
        .environment(appState)
    }

}

#Preview("AppView - Authenticated") {
    AppView(appState: AppState(isAuthenticated: true))
}

#Preview("AppView - Unauthenticated") {
    AppView(appState: AppState(isAuthenticated: false))
}
