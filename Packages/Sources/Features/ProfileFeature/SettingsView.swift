//
//  SettingsView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import Shared
import SharedModels
import SharedViews
import AuthStore
import UserStore
import RegistrationFeature
import SwiftUI

public struct SettingsView: View {

    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(AuthStore.self) private var authStore
    @Environment(UserStore.self) private var userStore

    @State private var isPremium = false
    @State private var isAnonymousUser = false
    @State private var showRegistrationView = false
    @State private var showAlert: AppAlert?

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            List {
                accountSection
                appInfoSection
                signOutSection
                deleteAccountSection
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            setAnonymousAuthStatus()
        }
        .sheet(
            isPresented: $showRegistrationView,
            onDismiss: {
                setAnonymousAuthStatus()
            },
            content: {
                RegistrationView()
                    .presentationDetents([.medium])
            }
        )
        .showCustomAlert(alert: $showAlert)
    }
    
    // MARK: - Components

    private var accountSection: some View {
        Section("ACCOUNT") {
            HStack {
                Text("Account status: \(isPremium ? "PREMIUM" : "FREE")")

                Spacer()

                if isPremium {
                    Text("MANAGE")
                        .font(.caption)
                        .foregroundStyle(Color.white)
                        .bold()
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .applyRowFormatting()
        }
        .removeListRowFormatting()
    }
    
    private var appInfoSection: some View {
        Section {
            HStack(spacing: 0) {
                Text("Version")
                    .foregroundStyle(.primary)

                Spacer(minLength: 4)

                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .applyRowFormatting()

            HStack(spacing: 0) {
                Text("Build number")
                    .foregroundStyle(.primary)

                Spacer(minLength: 4)

                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            .applyRowFormatting()

            Text("Contact us")
                .foregroundStyle(Color.accentColor)
                .applyRowFormatting()
        } header: {
            Text("App Info")
        } footer: {
            Text("Created by Jason.\nLearn more at www.google.ca")
                .baselineOffset(6)
                .padding(.vertical, 8)
        }
        .removeListRowFormatting()
    }
    
    private var signOutSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save and backup account")
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .anyButton(.highlight) {
                        onCreateAccountButtonTapped()
                    }
            } else {
                Text("Sign Out")
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .anyButton(.highlight) {
                        onSignOutButtonTapped()
                    }
            }
        }
    }

    private var deleteAccountSection: some View {
        Section {
            Button(action: onDeleteAccountButtonTapped) {
                Text("Delete Account")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    // MARK: - Actions

    private func onCreateAccountButtonTapped() {
        showRegistrationView = true
    }

    private func onSignOutButtonTapped() {
        Task {
            do {
                try await authStore.signOut()
                userStore.logout()
                await dismissScreen()
            } catch {
                showAlert = AppAlert(error: error)
            }
        }
    }

    private func onDeleteAccountButtonTapped() {
        showAlert = AppAlert(
            title: "Delete Account?",
            subtitle: "This action is permanent and cannot be undone. Your data will be deleted from our server.",
            buttons: {
                AnyView(Group {
                    Button("Delete", role: .destructive) {
                        onDeleteAccountConfirmed()
                    }
                    Button("Cancel", role: .cancel) {

                    }
                })
            })
    }

    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authStore.deleteAccount()
                try await userStore.deleteCurrentUser()
                await dismissScreen()
            } catch {
                showAlert = AppAlert(error: error)
            }
        }
    }

    private func dismissScreen() async {
        dismiss.callAsFunction()
        try? await Task.sleep(for: .seconds(1)) // sleep to trigger dismiss animation and then update root
        appState.updateAuthenticationState(false)
    }

    private func setAnonymousAuthStatus() {
        self.isAnonymousUser = authStore.auth?.isAnonymous == true
    }

}

fileprivate extension View {
    func applyRowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .padding(.vertical, 4)
            .background()
    }
}

// MARK: - Previews

#Preview("Anonymous") {
    SettingsView()
        .environment(AppState())
        .environment(AuthStore(service: .mockWithAnonymousUser))
        .environment(UserStore(service: .mock(user: .mock), local: .fileManager))
}

#Preview("Not Anonymous") {
    SettingsView()
        .environment(AppState())
        .environment(AuthStore(service: .mockWithUser))
        .environment(UserStore(service: .mock(user: .mock), local: .fileManager))
}
