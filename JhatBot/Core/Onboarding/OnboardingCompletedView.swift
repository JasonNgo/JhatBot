//
//  OnboardingCompletedView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct OnboardingCompletedView: View {

    @Environment(AppState.self) private var appState

    var body: some View {
        VStack {
            Text("Onboarding Complete")
                .frame(maxHeight: .infinity)

            Button(action: self.onActionButtonTapped) {
                Text("Finish")
                    .withCallToActionStyle()
            }
        }
        .padding()
    }

    private func onActionButtonTapped() {
        appState.updateAuthenticationState(true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
