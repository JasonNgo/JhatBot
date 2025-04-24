//
//  OnboardingIntroView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-24.
//

import SwiftUI

struct OnboardingIntroView: View {

    // MARK: - Body

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                calloutLabel
                messageLabel
            }
            .frame(maxHeight: .infinity)

            actionButton
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Components

    private var calloutLabel: some View {
        let attributedString: AttributedString = {
            var string = AttributedString("Make your own avatars and chat with them!")
            string.font = .title3

            if let range = string.range(of: "avatars") {
                string[range].foregroundColor = .accent
                string[range].font = .title3.weight(.semibold)
            }

            return string
        }()

        return Text(attributedString)
            .font(.caption)
            .foregroundColor(.black)
    }

    private var messageLabel: some View {
        let attributedString: AttributedString = {
            var string = AttributedString("Have real conversations with AI generated responses.")
            string.font = .title3

            if let range = string.range(of: "real conversations") {
                string[range].foregroundColor = .accent
                string[range].font = .title3.weight(.semibold)
            }

            return string
        }()

        return Text(attributedString)
            .font(.caption)
            .foregroundColor(.black)
    }

    private var actionButton: some View {
        NavigationLink {
            OnboardingColorView()
        } label: {
            Text("Continue")
                .withCallToActionStyle()
        }
    }

}

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
