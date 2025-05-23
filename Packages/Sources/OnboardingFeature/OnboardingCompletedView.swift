//
//  OnboardingCompletedView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SharedModels
import UserFeature
import SwiftUI

public struct OnboardingCompletedView: View {

    // MARK: - Properties

    @Environment(AppState.self) private var appState
    @Environment(UserManager.self) private var userManager
    @State private var isLoading = false

    // MARK: - Dependencies

    private var selectedColor: Color

    // MARK: - Initializers

    public init(selectedColor: Color) {
        self.selectedColor = selectedColor
    }

    // MARK: - Body

    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Setup Complete")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(selectedColor)

                Text("We've set up your profile and you're ready to start chatting.")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            .frame(maxHeight: .infinity)

            Button(action: self.onActionButtonTapped) {
                ZStack {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Finish")
                    }
                }
                .withCallToActionStyle()
            }
            .disabled(isLoading)
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Actions

    private func onActionButtonTapped() {
        isLoading = true

        Task {
            let profileColorHex = selectedColor.asHex()
            try await userManager.updateOnboardingStatusForCurrentUser(profileColorHex: profileColorHex)

            isLoading = false
            appState.updateAuthenticationState(true)
        }
    }

}

// MARK: - Previews

#Preview {
    OnboardingCompletedView(selectedColor: .orange)
        .environment(AppState())
        .environment(UserManager(service: .mock(user: .mock)))
}
