//
//  SettingsView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI
import Shared
import AvatarModule
import RegistrationFeature

public struct SettingsView: View {

    // MARK: - Properties

//    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    @State private var isPremium = false
    @State private var isAnonymousUser = false
    @State private var showRegistrationView = false

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
        .sheet(isPresented: $showRegistrationView) {
            RegistrationView()
                .presentationDetents([.medium])
        }
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
            Button(action: onSignOutButtonTapped) {
                if isAnonymousUser {
                    Text("Save and backup account")
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("Sign Out")
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
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

    private func onSignOutButtonTapped() {
        dismiss.callAsFunction()

        if isAnonymousUser {
            showRegistrationView = true
        } else {
            Task {
                try? await Task.sleep(for: .seconds(1))
                //            appState.updateAuthenticationState(false)
            }
        }
    }

    private func onDeleteAccountButtonTapped() {

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

#Preview {
    SettingsView()
        .environment(AppState())
}
