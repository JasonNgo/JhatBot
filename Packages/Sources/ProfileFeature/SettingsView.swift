//
//  SettingsView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI

struct SettingsView: View {

//    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                signOutButton
            }
            .navigationTitle("Settings")
        }
    }

    private var signOutButton: some View {
        Button(action: onSignOutButtonTapped) {
            Text("Sign Out")
        }
    }

    private func onSignOutButtonTapped() {
        dismiss.callAsFunction()

        Task {
            try? await Task.sleep(for: .seconds(1))
//            appState.updateAuthenticationState(false)
        }
    }

}

#Preview {
    SettingsView()
}
