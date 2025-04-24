//
//  MainView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct MainView: View {

    @State private var appState: AppState

    public init(appState: AppState = AppState()) {
        self.appState = appState
    }

    var body: some View {
        MainViewBuilder(
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

}

#Preview("MainView - Authenticated") {
    MainView(appState: AppState(isAuthenticated: true))
}

#Preview("MainView - Unauthenticated") {
    MainView(appState: AppState(isAuthenticated: false))
}
