//
//  WelcomeView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct WelcomeView: View {

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                AsyncImage(url: nil)
                    .ignoresSafeArea()

                textSection
                    .padding(.top, 24)

                ctaSection
                    .padding(16)

                policySection
            }
        }
    }

    // MARK: - Sections

    private var textSection: some View {
        VStack(spacing: 8) {
            titleLabel
            subtitleLabel
        }
    }

    private var ctaSection: some View {
        VStack(spacing: 12) {
            NavigationLink {
                OnboardingCompletedView()
            } label: {
                signUpButton
            }

            signInButton
        }
    }

    private var policySection: some View {
        HStack(alignment: .center) {
            termsOfServiceButton
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            privacyPolicyButton
        }
    }

    // MARK: - Components

    private var titleLabel: some View {
        Text("AI Chat 🤖")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
    }

    private var subtitleLabel: some View {
        Text("Powered by JhatBot")
            .font(.caption)
            .foregroundStyle(.secondary)
    }

    private var signUpButton: some View {
        Button(action: self.onSignUpButtonTapped) {
            Text("Get Started")
                .withCallToActionStyle()
        }
    }

    private var signInButton: some View {
        Button(action: self.onSignInButtonTapped) {
            Text("Already have an account? Sign In")
                .underline()
                .foregroundStyle(.black)
                .padding(8)
                .withTappableBackground {

                }
        }
    }

    private var termsOfServiceButton: some View {
        Button(action: self.onTermsOfServiceButtonTapped) {
            Text("Terms of Service")
                .foregroundStyle(.accent)
        }
    }

    private var privacyPolicyButton: some View {
        Button(action: self.onPrivacyPolicyButtonTapped) {
            Text("Privacy Policy")
                .foregroundStyle(.accent)
        }
    }

    // MARK: - Actions

    private func onSignUpButtonTapped() {

    }

    private func onSignInButtonTapped() {

    }

    private func onTermsOfServiceButtonTapped() {

    }

    private func onPrivacyPolicyButtonTapped() {

    }

}

#Preview {
    WelcomeView()
}
