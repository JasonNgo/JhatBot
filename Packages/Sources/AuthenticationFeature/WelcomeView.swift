//
//  WelcomeView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import Shared
import OnboardingFeature
import SwiftUI

public struct WelcomeView: View {

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ImageLoaderView()
                    .ignoresSafeArea()

                textSection
                    .padding(.top, 24)

                ctaSection
                    .padding(16)

                policySection
            }
        }
    }

    // MARK: - Properties

    // MARK: - Initializers

    public init() {
        
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
                OnboardingIntroView()
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
                .fill(Color.accentColor)
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
        Text("Get Started")
            .withCallToActionStyle()
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
                .foregroundStyle(Color.accentColor)
        }
    }

    private var privacyPolicyButton: some View {
        Button(action: self.onPrivacyPolicyButtonTapped) {
            Text("Privacy Policy")
                .foregroundStyle(Color.accentColor)
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

// MARK: - Previews

#Preview {
    NavigationStack {
        WelcomeView()
    }
    .environment(AppState())
}
