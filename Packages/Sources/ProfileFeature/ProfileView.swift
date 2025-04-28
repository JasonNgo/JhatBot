//
//  ProfileView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct ProfileView: View {

    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            Text(
                "Profile",
                comment: "A tab bar item that displays 'Profile' and a corresponding image."
            )
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    private var settingsButton: some View {
        Button(action: onSettingsButtonTapped) {
            Image(systemName: "gear")
        }
    }

    private func onSettingsButtonTapped() {
        showSettings = true
    }
}

#Preview {
    ProfileView()
}
