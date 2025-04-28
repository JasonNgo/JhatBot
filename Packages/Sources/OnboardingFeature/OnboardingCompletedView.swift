//
//  OnboardingCompletedView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import SwiftUI

public struct OnboardingCompletedView: View {

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

    // MARK: - Properties

    @Environment(AppState.self) private var appState

    @State private var isLoading = false

    private var selectedColor: Color

    // MARK: - Initializers

    public init(selectedColor: Color) {
        self.selectedColor = selectedColor
    }

    // MARK: - Actions

    private func onActionButtonTapped() {
        isLoading = true

        Task {
            try? await Task.sleep(for: .seconds(2))

            isLoading = false
            appState.updateAuthenticationState(true)
        }
    }

}

// MARK: - Previews

#Preview {
    OnboardingCompletedView(selectedColor: .orange)
        .environment(AppState())
}
