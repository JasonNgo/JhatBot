//
//  RegistrationView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import SharedViews
import AuthService
import SwiftUI

public struct RegistrationView: View {

    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss
    @Environment(\.authService) private var authService

    public private(set) var onDidSignIn: ((_ isNewUser: Bool) -> Void)?

    // MARK: - Initializers

    public init(
        onDidSignIn: ((_ isNewUser: Bool) -> Void)? = nil
    ) {
        self.onDidSignIn = onDidSignIn
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text("Don't lose your data! Connect to a SSO provider to save your account.")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10
            )
            .frame(height: 55)
            .anyButton(.press) {
                onSignInWithAppleButtonTapped()
            }

            Spacer()
        }
        .padding(16)
        .padding(.top, 24)
    }

    private func onSignInWithAppleButtonTapped() {
        Task {
            do {
                let result = try await authService.signInWithApple()
                onDidSignIn?(result.isNewUser)
                dismiss.callAsFunction()
            } catch {

            }
        }
    }

}

// MARK: - Previews

#Preview {
    RegistrationView()
}
