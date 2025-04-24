//
//  OnboardingCompletedView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct OnboardingCompletedView: View {

    // MARK: - Properties

    @Environment(AppState.self) private var appState

    @State private var isLoading = false

    private var selectedColor: Color

    // MARK: - Initializers

    init(selectedColor: Color) {
        self.selectedColor = selectedColor
    }

    // MARK: - Body

    var body: some View {
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

    private func onActionButtonTapped() {
        isLoading = true

        Task {
            try? await Task.sleep(for: .seconds(2))

            isLoading = false
            appState.updateAuthenticationState(true)
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: .orange)
        .environment(AppState())
}
